/* Explore job postings by listing job id, job titles, company names, 
and their average salary rates, 
while categorizing these salaries relative to the average in their 
respective countries.
 Include the month of the job posted date. Use CTEs, conditional logic, 
 and date functions,
  to compare individual salaries with national averages. */

WITH country_avg_salary AS(
    SELECT 
    job_country,
    AVG(salary_year_avg) AS salary_avg 
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL
GROUP BY
    job_country
)

SELECT 
    job_postings_fact.job_id,
    company_dim.name,
    job_postings_fact.job_title,
    CASE 
    WHEN job_postings_fact.salary_year_avg > country_avg_salary.salary_avg THEN 'Above Average'
    ELSE 'Below Average'
    END AS category_salary,

    EXTRACT (MONTH FROM job_postings_fact.job_posted_date) AS posted_month

    FROM
        job_postings_fact 
    INNER JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    INNER JOIN country_avg_salary ON job_postings_fact.job_country = country_avg_salary.job_country
    ORDER BY posted_month

SELECT * FROM job_postings_fact LIMIT 5 



WITH avg_salaries AS (
    SELECT 
        job_country, 
        AVG(salary_year_avg) AS avg_salary
    FROM job_postings_fact
    GROUP BY job_country
)
SELECT
    -- Gets basic job info
    job_postings.job_id,
    job_postings.job_title,
    companies.name AS company_name,
    job_postings.salary_year_avg AS salary_rate,
    -- categorizes the salary as above or below average the average salary for the country
    CASE
        WHEN job_postings.salary_year_avg > avg_salaries.avg_salary
        THEN 'Above Average'
        ELSE 'Below Average'
    END AS salary_category,
    -- gets the month and year of the job posting date
    EXTRACT(MONTH FROM job_postings.job_posted_date) AS posting_month
FROM
    job_postings_fact as job_postings
INNER JOIN
    company_dim as companies ON job_postings.company_id = companies.company_id
INNER JOIN
    avg_salaries ON job_postings.job_country = avg_salaries.job_country
ORDER BY
    -- Sorts it by the most recent job postings
    posting_month desc

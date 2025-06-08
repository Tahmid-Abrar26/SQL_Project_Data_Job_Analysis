WITH company_unique_skills AS (
SELECT
    company_dim.company_id,
    COUNT (DISTINCT skills_job_dim.skill_id) AS unique_skills
FROM
    company_dim
LEFT JOIN job_postings_fact ON 
    company_dim.company_id = job_postings_fact.company_id 

LEFT JOIN skills_job_dim ON
    job_postings_fact.job_id = skills_job_dim.job_id
GROUP BY company_dim.company_id

),

highest_salary_companies AS (
    SELECT
        company_dim.name,
        MAX(job_postings_fact.salary_year_avg) AS highest_salary 
    FROM 
        job_postings_fact
    LEFT JOIN company_dim ON
        job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_postings_fact.job_id IN (SELECT job_id FROM skills_job_dim)
   GROUP BY company_dim.name
)


SELECT 
    company_unique_skills.unique_skills,
    highest_salary_companies.highest_salary,
    company_dim.name
FROM company_dim
LEFT JOIN  company_unique_skills ON
    company_dim.company_id = company_unique_skills.company_id 
LEFT JOIN highest_salary_companies ON
    company_dim.name = highest_salary_companies.name
ORDER BY  
    company_dim.name



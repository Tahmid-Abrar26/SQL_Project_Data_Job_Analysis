 SELECT 
    first_quarter.job_title_short,
    first_quarter.job_location,
    first_quarter.job_via,
    first_quarter.salary_year_avg,
    skills_dim.skills,
    skills_dim.type
FROM 
 (SELECT *
FROM 
    january_jobs

UNION ALL 

SELECT *
FROM 
    february_jobs

UNION ALL

SELECT *
FROM 
    march_jobs
) AS first_quarter


LEFT JOIN skills_job_dim ON
    first_quarter.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON
    skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    first_quarter.salary_year_avg > 70000

ORDER BY first_quarter.job_id


SELECT
    COUNT(first_quarter.job_id) AS number_of_jobs,
    skills_dim.skills,
    EXTRACT (MONTH FROM job_posted_date) AS month_demand,
    EXTRACT (year FROM job_posted_date) AS year_demand
    FROM  


(SELECT *
FROM 
    january_jobs

UNION ALL 

SELECT *
FROM 
    february_jobs

UNION ALL

SELECT *
FROM 
    march_jobs
) AS first_quarter 

LEFT JOIN skills_job_dim ON
    first_quarter.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON
    skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY skills_dim.skills, month_demand, year_demand
    




    SELECT * FROM job_postings_fact LIMIT 5
     SELECT * FROM skills_dim LIMIT 5
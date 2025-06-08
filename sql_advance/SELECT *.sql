SELECT * 
FROM (
    SELECT * 
    FROM job_postings_fact 
    WHERE EXTRACT (MONTH FROM job_posted_date) = 1
) AS january_jobs


 SELECT 
        skill_id,
        COUNT(job_id) AS skill_count
    FROM skills_job_dim
    GROUP BY skill_id
    ORDER BY COUNT(job_id) DESC
    LIMIT 5


    SELECT * FROM job_postings_fact LIMIT 10 ; 


SELECT
    skills_dim.skills
    FROM skills_dim 
    INNER JOIN
(SELECT 
    skill_id,
    COUNT(job_id) AS skill_count
FROM skills_job_dim
GROUP BY skill_id
ORDER BY skill_count DESC
LIMIT 5) AS top_skills ON skills_dim.skill_id = top_skills.skill_id
ORDER BY top_skills.skill_count DESC;

WITH company_job_count AS
(SELECT
    company_id,
    COUNT(*) AS total_jobs
FROM
    job_postings_fact
GROUP BY
    company_id)
SELECt 
    company_dim.name,
    total_jobs
FROM company_dim
LEFT JOIN company_job_count ON company_dim.company_id=company_job_count.company_id
ORDER BY total_jobs DESC;

SELECT * FROM skills_dim LIMIT 5;


SELECT
    skill_id
FROM
    skills_job_dim AS skill_to_jobs
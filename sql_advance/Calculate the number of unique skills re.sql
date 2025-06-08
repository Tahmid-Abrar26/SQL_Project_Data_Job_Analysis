Calculate the number of unique skills required by each company.
 Aim to quantify the unique skills required per company and 
 identify which of these companies offer the highest average salary for
  positions necessitating
  at least one skill. For entities without skill-related job postings,
   list it as a zero skill requirement and a null salary.
    Use CTEs to separately assess the unique skill count and 
    the maximum average salary offered by these companies.

SELECT 
    company_dim.name,
  
    COUNT(DISTINCT skills_dim.skill_id) AS unique_skills
FROM job_postings_fact 
INNER JOIN company_dim ON
    job_postings_fact.company_id = company_dim.company_id
INNER JOIN skills_job_dim ON
    job_postings_fact.job_id = skills_job_dim.job_id
    GROUP BY company_dim.name




    SELECT
        companies.company_id,
        COUNT(DISTINCT skills_to_job.skill_id) AS unique_skills_required
    FROM
        company_dim AS companies 
    LEFT JOIN job_postings_fact as job_postings ON companies.company_id = job_postings.company_id
    LEFT JOIN skills_job_dim as skills_to_job ON job_postings.job_id = skills_to_job.job_id
    GROUP BY
        companies.company_id




WITH remote_jobs AS (
    SELECT 
        skills_job_dim.skill_id,
        skills_dim.skills,
        COUNT (job_work_from_home) AS total_remote_jobs
    FROM job_postings_fact
    LEFT JOIN skills_job_dim ON 
    job_postings_fact.job_id = skills_job_dim.job_id
    LEFT JOIN skills_dim ON
    skills_dim.skill_id = skills_job_dim.skill_id
    GROUP BY skills_job_dim.skill_id, skills_dim.skills
    ORDER BY total_remote_jobs DESC 
)

SELECT * FROM remote_jobs LIMIT 5


SELECT 
    job_title_short,
    company_id,
    job_location
FROM 
    january_jobs

UNION ALL

SELECT 
    job_title_short,
    company_id,
    job_location
FROM 
    february_jobs


    SELECT * FROM job_postings_fact LIMIT 5

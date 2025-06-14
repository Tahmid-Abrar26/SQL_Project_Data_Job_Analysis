WITH highest_paying_jobs AS (
    SELECT job_id,
	job_title,
	job_location,
	job_schedule_type,
	salary_year_avg,
	job_posted_date,
    name
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst' AND 
      job_location = 'Anywhere' AND 
      salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC)

SELECT 
    highest_paying_jobs.job_id,
    highest_paying_jobs.job_title,
    skills_dim.skills,
    highest_paying_jobs.salary_year_avg
FROM highest_paying_jobs  
LEFT JOIN skills_job_dim ON
    highest_paying_jobs.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON
    skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY highest_paying_jobs.salary_year_avg DESC



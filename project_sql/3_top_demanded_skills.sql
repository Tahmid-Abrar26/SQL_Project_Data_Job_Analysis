SELECT
    skills_dim.skills,
    COUNT(skills_dim.skill_id) AS in_demand_job
FROM
    job_postings_fact 
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.skill_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_postings_fact.job_title_short = 'Data Analyst' 
    AND job_work_from_home = TRUE
GROUP BY skills_dim.skills
ORDER BY in_demand_job DESC
LIMIT 5 


SELECT
    skills_dim.skills,
    ROUND(AVG(salary_year_avg), 0) as yearly_avg
FROM 
    job_postings_fact
LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
     AND salary_year_avg IS NOT NULL
     AND job_work_from_home = TRUE
GROUP BY skills_dim.skills
ORDER BY yearly_avg DESC
LIMIT 100
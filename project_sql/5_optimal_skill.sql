WITH high_demand AS (SELECT
    skills_dim.skills,
    skills_dim.skill_id,
    COUNT(skills_dim.skill_id) AS in_demand_job
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.skill_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_postings_fact.job_title_short = 'Data Analyst' 
   
    AND job_work_from_home = TRUE
GROUP BY skills_dim.skill_id

),
demanded_skills AS (SELECT
    skills_dim.skills,
    skills_dim.skill_id,
    ROUND(AVG(salary_year_avg), 0) as yearly_avg
FROM 
    job_postings_fact
LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
     AND salary_year_avg IS NOT NULL
     AND job_work_from_home = TRUE
GROUP BY skills_dim.skill_id
)

SELECT 
    high_demand.skills,
    high_demand.skill_id,
    high_demand.in_demand_job,
    demanded_skills.yearly_avg
FROM high_demand
INNER JOIN demanded_skills ON high_demand.skill_id = demanded_skills.skill_id
ORDER BY high_demand.in_demand_job DESC , demanded_skills.yearly_avg DESC




-- Another Solution

SELECT 
    skills_dim.skills,
    COUNT (skills_job_dim.skill_id) AS most_demand_count
FROM job_postings_fact
LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_postings_fact.job_title_short = 'Data Analyst'
GROUP BY skills_dim.skills
ORDER BY  most_demand_count DESC
LIMIT 10
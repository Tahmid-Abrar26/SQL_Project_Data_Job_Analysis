/*Identify companies with the most diverse (unique) 
job titles. 
Use a CTE to count the number of unique job titles per
 company, then select companies with the highest diversity 
 in job titles.*/

WITH company_haha AS
( 
    SELECT
    COUNT (DISTINCT job_postings_fact.job_title) AS CCA,
    company_dim.name
FROM 
    job_postings_fact
    INNER JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
GROUP BY
    company_dim.company_id
    ORDER BY CCA DESC
  
    ) 

SELECT * FROM company_haha 
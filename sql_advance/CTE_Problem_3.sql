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



/* 
here are the top paying job for data analyst, can you give me some quick insights into the some trends into top paying jobs

[
  {
    "skills": "pyspark",
    "yearly_avg": "208172"
  },
  {
    "skills": "bitbucket",
    "yearly_avg": "189155"
  },
  {
    "skills": "watson",
    "yearly_avg": "160515"
  },
  {
    "skills": "couchbase",
    "yearly_avg": "160515"
  },
  {
    "skills": "datarobot",
    "yearly_avg": "155486"
  },
  {
    "skills": "gitlab",
    "yearly_avg": "154500"
  },
  {
    "skills": "swift",
    "yearly_avg": "153750"
  },
  {
    "skills": "jupyter",
    "yearly_avg": "152777"
  },
  {
    "skills": "pandas",
    "yearly_avg": "151821"
  },
  {
    "skills": "golang",
    "yearly_avg": "145000"
  },
  {
    "skills": "elasticsearch",
    "yearly_avg": "145000"
  },
  {
    "skills": "numpy",
    "yearly_avg": "143513"
  },
  {
    "skills": "databricks",
    "yearly_avg": "141907"
  },
  {
    "skills": "linux",
    "yearly_avg": "136508"
  },
  {
    "skills": "kubernetes",
    "yearly_avg": "132500"
  },
  {
    "skills": "atlassian",
    "yearly_avg": "131162"
  },
  {
    "skills": "twilio",
    "yearly_avg": "127000"
  },
  {
    "skills": "airflow",
    "yearly_avg": "126103"
  },
  {
    "skills": "scikit-learn",
    "yearly_avg": "125781"
  },
  {
    "skills": "jenkins",
    "yearly_avg": "125436"
  },
  {
    "skills": "notion",
    "yearly_avg": "125000"
  },
  {
    "skills": "scala",
    "yearly_avg": "124903"
  },
  {
    "skills": "postgresql",
    "yearly_avg": "123879"
  },
  {
    "skills": "gcp",
    "yearly_avg": "122500"
  },
  {
    "skills": "microstrategy",
    "yearly_avg": "121619"
  },
  {
    "skills": "crystal",
    "yearly_avg": "120100"
  },
  {
    "skills": "go",
    "yearly_avg": "115320"
  },
  {
    "skills": "confluence",
    "yearly_avg": "114210"
  },
  {
    "skills": "db2",
    "yearly_avg": "114072"
  },
  {
    "skills": "hadoop",
    "yearly_avg": "113193"
  },
  {
    "skills": "snowflake",
    "yearly_avg": "112948"
  },
  {
    "skills": "git",
    "yearly_avg": "112000"
  },
  {
    "skills": "ibm cloud",
    "yearly_avg": "111500"
  },
  {
    "skills": "azure",
    "yearly_avg": "111225"
  },
  {
    "skills": "bigquery",
    "yearly_avg": "109654"
  },
  {
    "skills": "aws",
    "yearly_avg": "108317"
  },
  {
    "skills": "shell",
    "yearly_avg": "108200"
  },
  {
    "skills": "unix",
    "yearly_avg": "107667"
  },
  {
    "skills": "java",
    "yearly_avg": "106906"
  },
  {
    "skills": "ssis",
    "yearly_avg": "106683"
  },
  {
    "skills": "jira",
    "yearly_avg": "104918"
  },
  {
    "skills": "oracle",
    "yearly_avg": "104534"
  },
  {
    "skills": "dax",
    "yearly_avg": "104500"
  },
  {
    "skills": "looker",
    "yearly_avg": "103795"
  },
  {
    "skills": "sap",
    "yearly_avg": "102920"
  },
  {
    "skills": "nosql",
    "yearly_avg": "101414"
  },
  {
    "skills": "python",
    "yearly_avg": "101397"
  },
  {
    "skills": "r",
    "yearly_avg": "100499"
  },
  {
    "skills": null,
    "yearly_avg": "100013"
  },
  {
    "skills": "redshift",
    "yearly_avg": "99936"
  },
  {
    "skills": "qlik",
    "yearly_avg": "99631"
  },
  {
    "skills": "tableau",
    "yearly_avg": "99288"
  },
  {
    "skills": "ssrs",
    "yearly_avg": "99171"
  },
  {
    "skills": "spark",
    "yearly_avg": "99077"
  },
  {
    "skills": "c++",
    "yearly_avg": "98958"
  },
  {
    "skills": "c",
    "yearly_avg": "98938"
  },
  {
    "skills": "sas",
    "yearly_avg": "98902"
  },
  {
    "skills": "sql server",
    "yearly_avg": "97786"
  },
  {
    "skills": "javascript",
    "yearly_avg": "97587"
  },
  {
    "skills": "rust",
    "yearly_avg": "97500"
  },
  {
    "skills": "power bi",
    "yearly_avg": "97431"
  },
  {
    "skills": "sql",
    "yearly_avg": "97237"
  },
  {
    "skills": "phoenix",
    "yearly_avg": "97230"
  },
  {
    "skills": "flow",
    "yearly_avg": "97200"
  },
  {
    "skills": "bash",
    "yearly_avg": "96558"
  },
  {
    "skills": "t-sql",
    "yearly_avg": "96365"
  },
  {
    "skills": "visio",
    "yearly_avg": "95842"
  },
  {
    "skills": "unity",
    "yearly_avg": "95500"
  },
  {
    "skills": "powershell",
    "yearly_avg": "95275"
  },
  {
    "skills": "mysql",
    "yearly_avg": "95224"
  },
  {
    "skills": "mariadb",
    "yearly_avg": "95000"
  },
  {
    "skills": "php",
    "yearly_avg": "95000"
  },
  {
    "skills": "matlab",
    "yearly_avg": "94200"
  },
  {
    "skills": "alteryx",
    "yearly_avg": "94145"
  },
  {
    "skills": "cognos",
    "yearly_avg": "93264"
  },
  {
    "skills": "spss",
    "yearly_avg": "92170"
  },
  {
    "skills": "pascal",
    "yearly_avg": "92000"
  },
  {
    "skills": "github",
    "yearly_avg": "91580"
  },
  {
    "skills": "outlook",
    "yearly_avg": "90077"
  },
  {
    "skills": "clickup",
    "yearly_avg": "90000"
  },
  {
    "skills": "vb.net",
    "yearly_avg": "90000"
  },
  {
    "skills": "sqlite",
    "yearly_avg": "89167"
  },
  {
    "skills": "vba",
    "yearly_avg": "88783"
  },
  {
    "skills": "powerpoint",
    "yearly_avg": "88701"
  },
  {
    "skills": "microsoft teams",
    "yearly_avg": "87854"
  },
  {
    "skills": "excel",
    "yearly_avg": "87288"
  },
  {
    "skills": "c#",
    "yearly_avg": "86540"
  },
  {
    "skills": "html",
    "yearly_avg": "86438"
  },
  {
    "skills": "sheets",
    "yearly_avg": "86088"
  },
  {
    "skills": "ms access",
    "yearly_avg": "85519"
  },
  {
    "skills": "chef",
    "yearly_avg": "85000"
  },
  {
    "skills": "node.js",
    "yearly_avg": "83500"
  },
  {
    "skills": "arch",
    "yearly_avg": "82750"
  },
  {
    "skills": "word",
    "yearly_avg": "82576"
  },
  {
    "skills": "spring",
    "yearly_avg": "82000"
  },
  {
    "skills": "spreadsheet",
    "yearly_avg": "81892"
  },
  {
    "skills": "sharepoint",
    "yearly_avg": "81634"
  },
  {
    "skills": "webex",
    "yearly_avg": "81250"
  },
  {
    "skills": "zoom",
    "yearly_avg": "80740"
  },
  {
    "skills": "terminal",
    "yearly_avg": "80625"
  }
]


ChatGPT said:
Top Paying Data Analyst Skills (Sample Of Top 10)



Top 10 High Paying Data Analyst Skills


Here are the top 10 highest-paying skills for data analyst roles based on your data. A few quick insights:

🔍 Key Trends from the Top Paying Skills
High Demand for Big Data Tools

pyspark, jupyter, pandas lead the list—pointing to demand in big data processing and exploratory analysis.

Version Control & DevOps Knowledge Pays Off

Tools like bitbucket and gitlab highlight the growing importance of collaborative development and deployment in analytics workflows.

AI/ML Integration

datarobot, watson suggest employers are valuing analysts who can work with automated ML platforms and AI tools.

Programming Versatility

Languages like golang and swift show that even mobile/backend programming skills can boost a data analyst's value—likely in product analytics or tech-driven firms.

Tool-Based Specialization

Skills like couchbase (NoSQL DB) suggest a premium for those who can handle modern, scalable data infrastructures.


*/


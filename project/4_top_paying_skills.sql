/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for data analyst position.
- focuses on roles with specified salaries, regardless of location.
- why? it reveals how different skills impact salary levels for Data Analyst and helps identify the most financially rewardings skills to acquire or improve.
*/


select 
    skills,
    round(avg(salary_year_avg), 0) as avg_salary_per_year
from job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where 
    job_title_short = 'Data Analyst' AND
    salary_year_avg is not null
    and 
    job_work_from_home = 'True'
group by 
    skills
order by 
    avg_salary_per_year desc
LIMIT 25


/*
-- Big-data engineering pays the most. PySpark ($208,172) is the clear outlier, nearly $19k above the next skill, backed by Databricks, Airflow, Scala and Elasticsearch — the Spark/distributed-data ecosystem is where the premium lives.
-- Analysts who work like engineers earn more. DevOps tooling (Bitbucket, GitLab, Jenkins, Kubernetes, Linux) and the Python ML stack (Jupyter, Pandas, NumPy, scikit-learn, plus AI platforms Watson and DataRobot) fill most of the rest of the top 25.
-- Common skills don't top the pay list, and neither should the odd ones. SQL, Python, Tableau and Excel are absent because they're everywhere, so their averages sit lower — while Swift, Twilio and Notion are almost certainly one-or-two-posting noise, not real signals worth chasing.

*/
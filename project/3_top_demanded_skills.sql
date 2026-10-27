/*
Question: What are the most in_demand skills for the data analysts?
- join job postings to inner join table similar to query 2.
- Identfy the top 5 in_demand skills for a data analyst.
- focus on all job postings.
- why? retrieve the top 5 skills with the highest demand in the job market, provding insight into the most valuable skills for job seekers.
*/


select 
    skills,
    count(skills_job_dim.job_id) as demand_count
from job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where 
    job_title_short = 'Data Analyst' and 
    job_work_from_home = 'True'
group by 
    skills
order by 
    demand_count desc
LIMIT 5
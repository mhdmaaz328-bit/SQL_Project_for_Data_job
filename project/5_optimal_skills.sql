/*
Question: What are the mosy optimal skills to learn (aka it's in high demand and a high_paying skills)?
-Identify the skills in high demand and associated with high average salaries for the Data Analyst roles.
- Concertrate on remote psoition with specified salaries.
- Why? Targets skills that offer job security(high demand) and financial benefits (high salaries), offering strategic insights for career develpment in data analysis.
*/



with skills_demand as(
select 
    skills_dim.skill_id,
    skills_dim.skills,
    count(skills_job_dim.job_id) as demand_count
from job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where 
    job_title_short = 'Data Analyst' and 
    salary_year_avg is not null and
    job_work_from_home = 'True'
group by 
    skills_dim.skill_id
), average_salary as ( --if we run multiple CTE's we can group them together
select 
    skills_job_dim.skill_id,
    round(avg(salary_year_avg), 0) as avg_salary_per_year
from job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where 
    job_title_short = 'Data Analyst' AND
    salary_year_avg is not null and 
    job_work_from_home = 'True'
group by 
    skills_job_dim.skill_id
)

select
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary_per_year
from
    skills_demand
inner join average_salary on skills_demand.skill_id = average_salary.skill_id
where 
    demand_count > 10
order by 
    avg_salary_per_year DESC,
    demand_count desc
limit 25;


-- rewrite this query more concisely

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    count(skills_job_dim.job_id) as demand_count,
    round(avg(job_postings_fact.salary_year_avg), 0)   as avg_salary_per_year

from job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id

where 
    job_title_short ='Data Analyst' AND
    salary_year_avg is not NULl and 
    job_work_from_home = True 

group by 
    skills_dim.skill_id
HAVING
    count(skills_job_dim.job_id) > 10

order by 
    avg_salary_per_year DESC,
    demand_count DESC
LIMIT 25;
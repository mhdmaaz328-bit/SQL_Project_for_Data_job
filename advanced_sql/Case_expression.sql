/*
Label new column as follows:
- 'Anywhere' jobs as 'Remote'
- 'New York, NY' jobs as 'local'
- Otherwise 'Onsite'
*/

SELECT

--  job_title_short AS title,
--  job_location AS location,
    count(job_id) AS Number_of_jobs,
    CASE 
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS Location_Category

FROM
    job_postings_fact

WHERE 
  job_title_short = 'Data Analyst'

group by Location_Category
  
  


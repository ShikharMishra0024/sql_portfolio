-- More optimized solution with only one join 

select c.company_code, c.founder
, count(distinct e.lead_manager_code) as lm_count
, count(distinct e.senior_manager_code) as sm_count
, count(distinct e.manager_code) as m_count
, count(distinct e.employee_code) as e_count
from Employee e
join Company c on e.company_code=c.company_code
group by c.company_code, c.founder
order by c.company_code
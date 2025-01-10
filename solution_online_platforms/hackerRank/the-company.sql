with company_heirarchy as 
(
    select c.company_code, c.founder,
    lm.lead_manager_code,
    sm.senior_manager_code,
    m.manager_code,
    e.employee_code
    from Company c
    left join Lead_Manager lm on c.company_code=lm.company_code 
    left join Senior_Manager sm on c.company_code=sm.company_code and lm.lead_manager_code=sm.lead_manager_code
    left join Manager m on c.company_code=m.company_code and lm.lead_manager_code=m.lead_manager_code and sm.senior_manager_code=m.senior_manager_code
    left join Employee e on c.company_code=e.company_code and lm.lead_manager_code=e.lead_manager_code and sm.senior_manager_code=e.senior_manager_code and
    m.manager_code=e.manager_code
)
select company_code, founder
, count(distinct lead_manager_code) as lm_count
, count(distinct senior_manager_code) as sm_count
, count(distinct manager_code) as m_count
, count(distinct employee_code) as e_count
from company_heirarchy
group by company_code, founder
order by company_code
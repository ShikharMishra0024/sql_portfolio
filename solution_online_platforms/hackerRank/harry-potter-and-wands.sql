-- =============================================
-- Title: Ollivander's Inventory
-- Platform: HackerRank
-- Link: https://www.hackerrank.com/challenges/the-report/problem
-- =============================================

with ranked_wands as 
(   
    select id, code, coins_needed, power,
    row_number() over(partition by code, power order by coins_needed) as rnk
    from wands
    where code in (select code from wands_property where is_evil=0)
),
top_ranked_wands as 
(
    select * from ranked_wands 
    where rnk=1
)
select t.id, p.age, t.coins_needed, t.power
from top_ranked_wands as t
join wands_property p on t.code=p.code
order by t.power desc, p.age desc
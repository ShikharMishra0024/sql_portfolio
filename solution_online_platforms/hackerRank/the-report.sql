-- =============================================
-- Title: The Report
-- Platform: HackerRank
-- Link: https://www.hackerrank.com/challenges/the-report/problem
-- =============================================

select case when g.grade>=8 then s.name end as name
, g.grade, s.marks
from students s
join grades g on s.marks>=g.min_mark and s.marks<=g.max_mark
order by g.grade desc, s.name, s.marks;
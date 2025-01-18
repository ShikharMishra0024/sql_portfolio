-- =============================================
-- Title: Draw The Triangle 1
-- Platform: HackerRank
-- Link: https://www.hackerrank.com/challenges/draw-the-triangle-1
-- =============================================


-- reverse triangle
declare @p int=20;

with temp as 
(
	select '*' as star, 1 as num
	union all
	select '*', num+1 as num
	from temp
	where num<@p
),
temp2 as 
(
	select string_agg(star, ' ') as n_stars, max(num) as num
	from temp
),
temp3 as 
(
	select n_stars, num+@p-1 as num from temp2
	union all
	select left(n_stars, num-2), num-2 as num
	from temp3
	where num>1
)
select n_stars as pattern
from temp3;

-- =============================================
-- Title: The PADS
-- Platform: HackerRank
-- Link: https://www.hackerrank.com/challenges/the-pads/
-- =============================================

select Name+'('+left(Occupation, 1)+')' from OCCUPATIONS order by Name;

select 'There are a total of '+cast(count(Occupation) as varchar(10))+' '+lower(Occupation)+'s.'
from OCCUPATIONS
group by Occupation
ORDER BY count(Occupation), Occupation;  

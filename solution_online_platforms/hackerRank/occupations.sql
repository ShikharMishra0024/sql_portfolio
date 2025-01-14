-- =============================================
-- Title: Occupations
-- Platform: HackerRank
-- Link: https://www.hackerrank.com/challenges/occupations/
-- =============================================

with doctors as 
(
    select name, 
    row_number() over(order by name) as doc_rnk
    from OCCUPATIONS
    where occupation='Doctor'
),
Professors as 
(
    select name, 
    row_number() over(order by name) as prof_rnk
    from OCCUPATIONS
    where occupation='Professor'
),
Singers  as 
(
    select name, 
    row_number() over(order by name) as sing_rnk
    from OCCUPATIONS
    where occupation='Singer'
),
Actors  as 
(
    select name, 
    row_number() over(order by name) as act_rnk
    from OCCUPATIONS
    where occupation='Actor'
)
select d.name, p.name, s.name, a.name
from Doctors d
full join Professors p on d.doc_rnk=p.prof_rnk
full join Singers s on d.doc_rnk=s.sing_rnk or p.prof_rnk=s.sing_rnk
full join Actors a on d.doc_rnk=a.act_rnk or p.prof_rnk=a.act_rnk or s.sing_rnk=a.act_rnk
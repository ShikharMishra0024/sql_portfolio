-- =============================================
-- Title: Challenges
-- Platform: HackerRank
-- Link: https://www.hackerrank.com/challenges/challenges/
-- =============================================

with temp as 
(
    select hacker_id, count(challenge_id) as challenges_created
    from challenges
    group by hacker_id
),
temp2 as 
(
    select max(hacker_id) as hacker_id, challenges_created
    from temp
    where challenges_created<(select max(challenges_created) from temp)
    group by challenges_created
    having count(*)=1
),
temp3 as 
(
    select hacker_id, challenges_created
    from temp where challenges_created=(select max(challenges_created) from temp)
    union all 
    select * from temp2
)
select temp3.hacker_id, h.name, temp3.challenges_created
from temp3
join hackers h on temp3.hacker_id=h.hacker_id
order by 3 desc, 1;
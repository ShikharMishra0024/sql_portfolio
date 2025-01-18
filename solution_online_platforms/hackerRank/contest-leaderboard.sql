-- =============================================
-- Title: Contest Leaderboard
-- Platform: HackerRank
-- Link: https://www.hackerrank.com/challenges/contest-leaderboard
-- =============================================

with temp as 
(
    select hacker_id, max(score) as max_score
    from submissions
    group by hacker_id, challenge_id
),
temp2 as 
(
    select hacker_id, sum(max_score) as total_score
    from temp
    group by hacker_id
)
select t.hacker_id, h.name, t.total_score
from (select * from temp2 where total_score > 0) t
join hackers h on t.hacker_id=h.hacker_id
order by t.total_score desc, t.hacker_id
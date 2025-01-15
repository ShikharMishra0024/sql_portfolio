-- =============================================
-- Title: Top Competitors
-- Platform: HackerRank
-- Link: https://www.hackerrank.com/challenges/full-score/
-- =============================================

with hacker_full_scored as (
    select s.hacker_id, count(distinct s.challenge_id) as chal_count
    from Submissions s
    inner join Challenges c on s.challenge_id=c.challenge_id
    inner join Difficulty d on c.difficulty_level=d.difficulty_level
    where s.score=d.score
    group by s.hacker_id
)
select h.hacker_id, ' '+h.name
from hacker_full_scored cte
inner join Hackers h on cte.hacker_id=h.hacker_id
where cte.chal_count>1
order by cte.chal_count desc, h.hacker_id;
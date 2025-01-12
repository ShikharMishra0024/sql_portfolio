-- =============================================
-- Title: Merge Overlapping Events in the Same Hall
-- Platform: leetcode
-- Link: https://leetcode.com/problems/merge-overlapping-events-in-the-same-hall
-- =============================================

with cte as
(
	select *,
	row_number() over(order by hall_id, start_date) as event_id
	from hall_events
),
r_cte as
(
	select *, 1 as flag from cte where event_id=1
	union all
	select cte.*,
	case when cte.hall_id=r_cte.hall_id and (cte.start_date between r_cte.start_date and r_cte.end_date) 
	then 0 else 1 end + flag as flag
	from r_cte
	inner join cte on r_cte.event_id+1=cte.event_id
)
select hall_id, min(start_date)  as start_date, max(end_date) as end_date
from r_cte
group by hall_id, flag

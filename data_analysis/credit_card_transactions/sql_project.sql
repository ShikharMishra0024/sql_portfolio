select * from credit_card_habits


-- write a query to print top 5 cities with highest spends and their 
-- percentage contribution of total credit card spends 
with total_spend as (
	select sum(cast(amount as bigint)) as total from credit_card_habits
)
select top 5 city, cast((sum(amount)*100.0)/min(t.total) as decimal(10, 2)) as perc_contribution
from credit_card_habits
join total_spend t on 1=1
group by city
order by sum(amount) desc;


-- write a query to print highest spend month and 
-- amount spent in that month for each card type
with monthy_spend as
(
	select datepart(month, Date) as month, sum(amount) as total_spend
	from credit_card_habits
	group by datepart(month, date)
),
month_ranking as (
	select month, dense_rank() over(order by total_spend desc) as rnk
	from monthy_spend
),
top_spend_month as (
	select month from month_ranking where rnk=1
)
select datepart(month, Date) as "month", Card_Type, sum(amount) as total_card_spend
from credit_card_habits, top_spend_month tsm
where datepart(month, Date) = tsm.month
group by datepart(month, date), Card_Type


-- write a query to print the transaction details(all columns from the table)
-- for each card type when it reaches a cumulative of 1000000
-- total spends(We should have 4 rows in the o/p one for each card type) and aslo 
-- create a virtual view of it
create view credit_card_milestone as 
with cum_spend_card_wise as 
(
	select *, 
	sum(amount) over(partition by Card_Type order by Date/*, "index"*/ rows between unbounded preceding and current row) as cum_spend
	from credit_card_habits
),
cum_milestone_trans as (
	select Card_Type, min(cum_spend) as cum_spend
	from cum_spend_card_wise
	where cum_spend >= 1000000
	group by Card_Type
)
select cr."index", cr.City, cr.Date, cr.Card_Type, cr.Exp_Type, cr.Gender, cr.Amount
from cum_milestone_trans ct
left join cum_spend_card_wise cr on 
ct.Card_Type=cr.Card_Type and
ct.cum_spend=cr.cum_spend;

select * from credit_card_milestone;


-- write a query to find city which had lowest percentage spend for gold card type
select top 1 city, sum(amount) as total_spend
from credit_card_habits
where card_type='gold'
group by city
order by total_spend

-- write a query to print 3 columns:  city, highest_expense_type , lowest_expense_type 
-- (example format : Delhi , bills, Fuel)
with temp as (
select city, exp_type, sum(amount) as total_spend
from credit_card_habits
group by city, exp_type
)
select distinct * from (
select city
, first_value(exp_type) over(partition by city order by total_spend desc) as highest_expense_type
, first_value(exp_type) over(partition by city order by total_spend) as lowest_expense_type
from temp
) a


-- write a query to find percentage contribution of spends by females for each expense type
with temp as (select sum(cast(amount as bigint)) as total_spend from credit_card_habits)
select 'Female' as gender, exp_type, cast(sum(amount)*100.0/min(temp.total_spend) as decimal(10, 2)) as perc_spend
from credit_card_habits, temp
where gender = 'F'
group by exp_type


-- which city took least number of days to reach its 500th transaction after the first transaction in that city
with temp as 
(
	select city, date,
	row_number() over(partition by city order by date) as rnk
	from credit_card_habits
),
temp2 as 
(
	select city, datediff(day, date, lead(date) over(partition by city order by rnk)) as days_to_reach_500th_trans, rnk
	from temp
	where rnk in (1, 500)
)
select top 1 city
from temp2
where days_to_reach_500th_trans is not null
order by days_to_reach_500th_trans;


-- which card and expense type combination saw highest month over month growth in Jan-2014
WITH temp as 
(select card_type, exp_type, 
sum(case when datepart(month, date) = 12 then amount else 0 end) as sales_dec_2013,
sum(case when datepart(month, date) = 01 then amount else 0 end) as sales_jan_2014
from credit_card_habits
where date between '2013-12-01' and '2014-01-31'
group by card_type, exp_type 
)
select top 1 card_type, exp_type, (sales_jan_2014-sales_dec_2013)*1.0/sales_dec_2013 as momg_jan_2014
from temp 
order by momg_jan_2014 desc;



-- during weekends which city has highest total spend to total no of transcations ratio 
select city, sum(amount)/count(*) as spend_trans_ratio
from credit_card_habits
where DATENAME(weekday, date) in ('saturday', 'sunday')
group by city 
order by spend_trans_ratio desc, city
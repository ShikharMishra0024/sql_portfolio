create table leethard.sales (
product_id int,
period_start date,
period_end date,
average_daily_sales int
);

insert into leethard.sales 
values(1,'2019-01-25','2019-02-28',100),
(2,'2018-12-01','2020-01-01',10),
(3,'2019-12-01','2020-01-31',1);

-- solution
with dates as
(
	select min(period_start) as date, max(period_end) as max_date from leethard.sales
	
	union all

	select dateadd(day, 1, date) as date, max_date
	from dates
	where date < max_date
)
select s.product_id,
datepart(YEAR, d.date) as year,
sum(s.average_daily_sales) as total_amount 
from leethard.sales s  
left join dates d on s.period_start <=d.date and s.period_end >= d.date
group by s.product_id, datepart(YEAR, d.date)
-- order by 1
option (maxrecursion 1000);
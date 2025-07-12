create table yt.customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);

insert into yt.customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000)
;
select * from yt.customer_orders;


-- solution
with cte1 as 
(
	select customer_id, min(order_date) as joining_date
	from yt.customer_orders group by customer_id
),
cte2 as 
(
	select joining_date as order_date, count(customer_id) as new_customers
	from cte1 group by joining_date
),
cte3 as 
(
	select order_date, count(customer_id) as total_customers
	from yt.customer_orders group by order_date
)
select cte2.order_date, cte2.new_customers,
(cte3.total_customers - coalesce(cte2.new_customers, 0)) as old_customers
from cte3
left join cte2 on cte3.order_date=cte2.order_date;
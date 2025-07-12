with top_20_perc_product_by_sales as 
(
	select top (cast(0.2*(select count(distinct product_id) from Orders) as int)) 
	product_id, product_name, sum(sales) as total_product_sales
	from orders
	group by product_id, product_name
	order by total_product_sales desc
)
select sum(total_product_sales) as top_20perc_sales from top_20_perc_product_by_sales;

--top_20_perc_product_by_sales
-- product giving 80% sales

with total_product_sale as 
(
	select product_id, sum(sales) as sales
	from orders
	group by product_id
),
rolling_sales as (
	select product_id, 
	sum(sales) over(order by sales desc rows between unbounded preceding and current row) as _rolling_sales
	from total_product_sale
),
product_giving_80perc_sales as (
	select * 
	from rolling_sales
	where _rolling_sales <= (select sum(sales) from orders)*0.8
)
select max(_rolling_sales) as top_80perc_sales from product_giving_80perc_sales

--select * from orders
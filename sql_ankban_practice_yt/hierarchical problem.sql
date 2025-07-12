CREATE TABLE yt.input_table_1 (
    Market VARCHAR(50),
    Sales INT
);

INSERT INTO yt.input_table_1 (Market, Sales) VALUES
('India', 100),
('Maharashtra', 20),
('Telangana', 18),
('Karnataka', 22),
('Gujarat', 25),
('Delhi', 12),
('Nagpur', 8),
('Mumbai', 10),
('Agra', 5),
('Hyderabad', 9),
('Bengaluru', 12),
('Hubli', 12),
('Bhopal', 5);

CREATE TABLE yt.input_table_2 (
    Country VARCHAR(50),
    State VARCHAR(50),
    City VARCHAR(50)
);
delete from yt.input_table_2;
INSERT INTO yt.input_table_2 (Country, State, City) VALUES
('India', 'Maharashtra', 'Nagpur'),
('India', 'Maharashtra', 'Mumbai'),
('India', 'Maharashtra', 'Akola'),
('India', 'Telangana', 'Hyderabad'),
('India', 'Karnataka', 'Bengaluru'),
('India', 'Karnataka', 'Hubli'),
('India', 'Gujarat', 'Ahmedabad'),
('India', 'Gujarat', 'Vadodara'),
('India', 'UP', 'Agra'),
('India', 'UP', 'Mirzapur'),
('India', 'Delhi', NULL), 
('India', 'Orissa', NULL); 


select * from yt.input_table_2;
select * from yt.input_table_1;

with cte1 as (
	select t2.*, t1.sales as city_sales from yt.input_table_2 t2
	join yt.input_table_1 t1 on t1.Market=t2.city
	union all 
	select country, state, null, null from yt.input_table_2 group by country, state
),
cte2 as (
	select cte1.*, coalesce(t1.Sales, 0) as state_sales, coalesce(sum(cte1.city_sales) over(partition by state), 0) as total_majority_sales_state from cte1
	left join yt.input_table_1 t1 on t1.Market=cte1.state
),
cte3 as (
	select country, state, city, coalesce(city_sales, state_sales - total_majority_sales_state, 0) as sales from cte2
	union all
	select country, null, null, null from yt.input_table_2 group by country
),
cte4 as (
	select country, state, city, coalesce(cte3.sales, t1.sales-
	sum(cte3.sales) over(partition by cte3.country)) as sales
	from cte3 
	left join yt.input_table_1 t1 on t1.Market=cte3.country
)
select * from cte4 where sales != 0;

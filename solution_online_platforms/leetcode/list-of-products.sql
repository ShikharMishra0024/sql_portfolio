-- =============================================
-- Title: List the Products Ordered in a Period
-- Platform: leetcode
-- Link: https://leetcode.com/problems/list-the-products-ordered-in-a-period
-- =============================================


with product_sold_feb_2020 as  
(select product_id, sum(unit) as unit
from Orders
where order_date between '2020-02-01' and '2020-02-29'
group by product_id
having sum(unit)>=100 
)
select p.product_name, o.unit
from product_sold_feb_2020 o
join Products p on o.product_id=p.product_id

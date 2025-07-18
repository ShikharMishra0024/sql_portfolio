create table leethard.users (
user_id int,
join_date date,
favorite_brand varchar(50));

drop table if exists leethard.orders;
 create table leethard.orders (
 order_id       int     ,
 order_date     date    ,
 item_id        int     ,
 buyer_id       int     ,
 seller_id      int 
 );

 drop table if exists leethard.items;
 create table leethard.items
 (
 item_id        int     ,
 item_brand     varchar(50)
 );


 insert into leethard.users 
 values (1,'2019-01-01','Lenovo'),
 (2,'2019-02-09','Samsung'),
 (3,'2019-01-19','LG'),
 (4,'2019-05-21','HP');

 insert into leethard.items 
 values (1,'Samsung'),
 (2,'Lenovo'),
 (3,'LG'),
 (4,'HP');

 insert into leethard.orders 
 values (1,'2019-08-01',4,1,2),
 (2,'2019-08-02',2,1,3),
 (3,'2019-08-03',3,2,3),
 (4,'2019-08-04',1,4,2),
 (5,'2019-08-04',1,3,4),
 (6,'2019-08-05',2,2,4);

-- solution

with seller_order_no as
(
	select seller_id, item_id,
	rank() over(partition by seller_id order by order_date) as rnk
	from leethard.orders
), second_sell as 
(
	select seller_id, item_id
	from seller_order_no s
	where rnk=2
)
select u.user_id as seller_id, 
case when i.item_brand=u.favorite_brand then 'yes' else 'no' end as is_2nd_sell_fav_brand
from second_sell s
join leethard.items i on s.item_id=i.item_id
-- catch here: every  user is a seller even if not sold a single item
right join leethard.users u on s.seller_id=u.user_id;
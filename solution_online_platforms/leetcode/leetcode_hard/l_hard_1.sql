Create table  leethard.Trips (id int, client_id int, driver_id int, city_id int, status varchar(50), request_at varchar(50));
Create table leethard.Users (users_id int, banned varchar(50), role varchar(50));
Truncate table leethard.Trips;
insert into leethard.Trips (id, client_id, driver_id, city_id, status, request_at)
values 
('1', '1', '10', '1', 'completed', '2013-10-01')
,('2', '2', '11', '1', 'cancelled_by_driver', '2013-10-01')
,('3', '3', '12', '6', 'completed', '2013-10-01')
,('4', '4', '13', '6', 'cancelled_by_client', '2013-10-01')
,('5', '1', '10', '1', 'completed', '2013-10-02')
,('6', '2', '11', '6', 'completed', '2013-10-02')
,('7', '3', '12', '6', 'completed', '2013-10-02')
,('8', '2', '12', '12', 'completed', '2013-10-03')
,('9', '3', '10', '12', 'completed', '2013-10-03')
,('10', '4', '13', '12', 'cancelled_by_driver', '2013-10-03');
Truncate table leethard.Users;
insert into leethard.Users (users_id, banned, role) values ('1', 'No', 'client')
,('2', 'Yes', 'client')
,('3', 'No', 'client')
,('4', 'No', 'client')
,('10', 'No', 'driver')
,('11', 'No', 'driver')
,('12', 'No', 'driver')
,('13', 'No', 'driver');
with trips as 
(
select * 
from leethard.trips
where request_at between '2013-10-01' and '2013-10-03'
),
banned_users as
(
select users_id
from leethard.users
where banned = 'yes'
)
select trips.request_at, 
round(count(case when trips.status != 'completed' then 1 end)*1.0/count(1), 2) as cancellation_rate
from trips
left join banned_users b on trips.client_id=b.users_id
left join banned_users bn on trips.driver_id=bn.users_id
where b.users_id is null AND bn.users_id is null
group by trips.request_at
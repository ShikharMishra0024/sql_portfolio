create table yt.entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into yt.entries 
values 
('A','Bangalore','A@gmail.com',1,'CPU'),
('A','Bangalore','A1@gmail.com',1,'CPU'),
('A','Bangalore','A2@gmail.com',2,'DESKTOP'),
('B','Bangalore','B@gmail.com',2,'DESKTOP'),
('B','Bangalore','B1@gmail.com',2,'DESKTOP'),
('B','Bangalore','B2@gmail.com',1,'MONITOR'),
('C','Bangalore','C@gmail.com',2,'DESKTOP'),
('C','Bangalore','C1@gmail.com',2,'DESKTOP'),
('C','Bangalore','C2@gmail.com',1,'MONITOR'),
('C','Bangalore','C3@gmail.com',1,'DESKTOP');


select * from yt.entries

-- solution

with resources_used as
(
	select name, string_agg(resources, ', ') as resources_used from
	(select name, resources from yt.entries group by name, resources) subq
	group by name
), 
visit_freq as 
(
	select name, floor, 
	dense_rank() over(partition by name order by visit_freq desc) as "rank"
	from
	(select name, floor, count(1) as visit_freq from yt.entries
	group by name,floor) sub_q
),
most_visited_floor as 
(
	select name, 
	string_agg(cast("floor" as varchar(2)), ', ') as most_visited_floor
	from
	(select name, "floor" from visit_freq where "rank"=1) sub_q
	group by name
),
total_visits as 
(
	select name, count(1) as total_visits
	from yt.entries group by name
)
select t.name, t.total_visits, m.most_visited_floor, r.resources_used
from resources_used r
inner join most_visited_floor m on r.name=m.name
inner join total_visits t on r.name=t.name
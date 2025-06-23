create table leethard.players
(player_id int,
group_id int)

insert into leethard.players values (15,1);
insert into leethard.players values (25,1);
insert into leethard.players values (30,1);
insert into leethard.players values (45,1);
insert into leethard.players values (10,2);
insert into leethard.players values (35,2);
insert into leethard.players values (50,2);
insert into leethard.players values (20,3);
insert into leethard.players values (40,3);

create table leethard.matches
(
match_id int,
first_player int,
second_player int,
first_score int,
second_score int)

insert into leethard.matches values (1,15,45,3,0);
insert into leethard.matches values (2,30,25,1,2);
insert into leethard.matches values (3,30,15,2,0);
insert into leethard.matches values (4,40,20,5,2);
insert into leethard.matches values (5,35,50,1,1);

select * from leethard.matches;
select * from leethard.players;

-- ==============================================
-- solution

with cte as 
(
	select first_player as player_id, first_score as score from leethard.matches
	union all
	select second_player, second_score from leethard.matches
)
,players_score as 
(
	select player_id, sum(score) as total_score
	from cte
	group by player_id
), players_ranking_in_grp as 
(
	select p.group_id, p.player_id, 
	rank() over(partition by p.group_id order by ps.total_score desc, p.player_id asc) as rnk
	from players_score ps
	left join leethard.players p on ps.player_id=p.player_id
)
select group_id, player_id
from players_ranking_in_grp
where rnk=1;
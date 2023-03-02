
-- 8- Leetcode Hard problem 2| Tournament Winners | Complex SQL 8

--create table players
--(player_id int,
--group_id int)

--insert into players values (15,1);
--insert into players values (25,1);
--insert into players values (30,1);
--insert into players values (45,1);
--insert into players values (10,2);
--insert into players values (35,2);
--insert into players values (50,2);
--insert into players values (20,3);
--insert into players values (40,3);


--create table matches
--(
--match_id int,
--first_player int,
--second_player int,
--first_score int,
--second_score int)

--insert into matches values (1,15,45,3,0);
--insert into matches values (2,30,25,1,2);
--insert into matches values (3,30,15,2,0);
--insert into matches values (4,40,20,5,2);
--insert into matches values (5,35,50,1,1);
------------------------------------------------------------


Select * from players
Select * from matches
go

--USING MULTIPLE CTEs and Dense_Rank()

with cte_all_players as 
(
	Select first_player as player,first_score as score from matches
	union all
	Select second_player as player,second_score as score from matches
),
cte_players_score as
(
	select player,sum(score) as total_scores
	from cte_all_players 
	group by player
), 
cte_winner as 
(
	select * ,  dense_rank() Over(Partition by p.group_id order by c.total_scores desc, player asc ) as Rnk
	from cte_players_score c
	inner join players p 
	on c.player = p.player_id
)
select group_id as [Group_name], player_id as [Winner], total_scores as [Scores] 
from cte_winner where rnk=1

------------------------------------------------------------
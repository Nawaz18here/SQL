/*
In this video we will discuss a problem where we need to
find player with no of gold medals won by them only for players who won only gold medals.
*/

--script:
--CREATE TABLE events (
--ID int,
--event varchar(255),
--YEAR INt,
--GOLD varchar(255),
--SILVER varchar(255),
--BRONZE varchar(255)
--);

--delete from events;

--INSERT INTO events VALUES (1,'100m',2016, 'Amthhew Mcgarray','donald','barbara');
--INSERT INTO events VALUES (2,'200m',2016, 'Nichole','Alvaro Eaton','janet Smith');
--INSERT INTO events VALUES (3,'500m',2016, 'Charles','Nichole','Susana');
--INSERT INTO events VALUES (4,'100m',2016, 'Ronald','maria','paula');
--INSERT INTO events VALUES (5,'200m',2016, 'Alfred','carol','Steven');
--INSERT INTO events VALUES (6,'500m',2016, 'Nichole','Alfred','Brandon');
--INSERT INTO events VALUES (7,'100m',2016, 'Charles','Dennis','Susana');
--INSERT INTO events VALUES (8,'200m',2016, 'Thomas','Dawn','catherine');
--INSERT INTO events VALUES (9,'500m',2016, 'Thomas','Dennis','paula');
--INSERT INTO events VALUES (10,'100m',2016, 'Charles','Dennis','Susana');
--INSERT INTO events VALUES (11,'200m',2016, 'jessica','Donald','Stefeney');
--INSERT INTO events VALUES (12,'500m',2016,'Thomas','Steven','Catherine');


Select * from events e1
go 

-- Using Subuery

--Select Gold,count(gold) as Count_Gold
--from
--	(
--		Select * from events e1
--		where gold not in ( Select silver from events e1 )
--	) a 
--where gold not in ( Select bronze from events e1 )
--group by gold

------------------------------------------------------------------
-- USING CTE 

--With Cte as (
--	Select gold 'Player','Gold' as 'Medal' from events e1
--	union all 
--	Select silver 'Player','Silver' from events e1
--	union all 
--	Select bronze 'Player','Bronze' from events e1
--)

--Select c1.Player,Count(Medal) as Cnt_med from Cte c1
--group by player
--having count(distinct medal) =1 and max(medal)='gold'


------------------------------------------------------------------

-- Using LEFT JOIN

--select e1.gold as player, count(e1.gold) as Cnt_gold from events e1
--left join events e2 on e1.gold=e2.silver
--left join events e3 on e1.gold= e3.bronze
--where e2.silver is null and e3.bronze is null
--group by e1.gold


------------------------------------------------------------------

-- Using union and Subquery

--Select Gold as Player,count(gold) as Count_Gold
--from
--	(
--		Select * from events e1
--		where gold not in ( Select silver from events e1 union all Select bronze from events e1 )
--	) a 
--group by gold


------------------------------------------------------------------

--USING INNER JOIN 

Select e1.gold as Player, Count(e1.gold) as Gold_medal_cnt from events e1 where gold not in (
Select e1.gold from events e1 inner join events e2 on e1.gold=e2.SILVER or e1.gold=e2.BRONZE )
group by e1.gold




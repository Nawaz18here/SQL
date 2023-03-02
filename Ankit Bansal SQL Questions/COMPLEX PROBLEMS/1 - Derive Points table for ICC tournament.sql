
-- Complex SQL Query 1 | Derive Points table for ICC tournament

--create table icc_world_cup
--(
--Team_1 Varchar(20),
--Team_2 Varchar(20),
--Winner Varchar(20)
--);
--INSERT INTO icc_world_cup values('India','SL','India');
--INSERT INTO icc_world_cup values('SL','Aus','Aus');
--INSERT INTO icc_world_cup values('SA','Eng','Eng');
--INSERT INTO icc_world_cup values('Eng','NZ','NZ');
--INSERT INTO icc_world_cup values('Aus','India','India');


------------------------------------------------------------

select * from icc_world_cup;

-- USING UNION ALL AND CASE STATEMENT 

Select team, 
COUNT(team) as Match_Played,
COUNT(case when winner=Team then Team end) as No_Of_Wins ,
COUNT(case when winner!=Team then Team end ) as No_Of_Loss 
from 
(
	select Team_1 as Team , team_2 , Winner from icc_world_cup
	union all
	select Team_2 as Team,team_1 , Winner from icc_world_cup
) a
group by team

------------------------------------------------------------

-- WE CAN USE IIF FUNCTION INSTEAD OF CASE STATEMENT 


Select team, 
COUNT(team) as Match_Played,
COUNT( IIF(winner=Team ,Team, NULL ) ) as No_Of_Wins ,
COUNT( IIF(winner!=Team ,Team, NULL ) ) as No_Of_Loss 
from 
(
	select Team_1 as Team , team_2 , Winner from icc_world_cup
	union all
	select Team_2 as Team,team_1 , Winner from icc_world_cup
) a
group by team

------------------------------------------------------------

-- USING CTE and SUM 

With cte as 
(
	select Team_1 as Team , Winner from icc_world_cup
	union all
	select Team_2 , Winner from icc_world_cup
)
select team , count(1) as Total_match_played,
SUM(case when winner=Team then 1 else 0 end) as No_Of_Wins ,
COUNT(case when winner!=Team then 1 else 0 end ) as No_Of_Loss 
from cte
group by team




--11th Question
--Write SQL to display total number of matches played, matches won, matches tied and matches lost for each team

--Create Table Match_Result (
--Team_1 Varchar(20),
--Team_2 Varchar(20),
--Result Varchar(20)
--)
--Insert into Match_Result Values('India', 'Australia','India');
--Insert into Match_Result Values('India', 'England','England');
--Insert into Match_Result Values('SouthAfrica', 'India','India');
--Insert into Match_Result Values('Australia', 'England',NULL);
--Insert into Match_Result Values('England', 'SouthAfrica','SouthAfrica');
--Insert into Match_Result Values('Australia', 'India','Australia');


Select * from Match_Result
go 


--- 1st SOLUTION

Select Team, SUM(Match_won) + SUM(Match_Loss) + SUM(Match_Tie) as TOTAL, 
SUM(Match_won) as WON, SUM(Match_Tie) as TIE,SUM(Match_Loss) as LOSS from  
(
Select Team_1 as Team,
SUM(Case When Result=Team_1 then 1 else 0 END ) as Match_won,
SUM(Case When Result=Team_2 then 1 else 0 END ) as Match_Loss,
SUM(Case When Result is null then 1 else 0 END ) as Match_Tie
from Match_result
group by Team_1

UNION ALL

Select Team_2 as Team,
SUM(Case When Result=Team_2 then 1 else 0 END ) as Match_won,
SUM(Case When Result=Team_1 then 1 else 0 END ) as Match_Loss,
SUM(Case When Result is null then 1 else 0 END ) as Match_Tie
from Match_result
group by Team_2 
) k Group by Team


-- 2nd Solution
with matches as 
(
SELECT team_1 as Team,Result from Match_Result
UNION ALL
SELECT team_2,result from Match_Result
)
SELECT 
	Team,
	COUNT(1)  matchs,
	SUM(case when Result = Team then 1 else 0 end)  wins,
	SUM(case when Result IS NULL then 1 else 0 end)  ties,
	SUM(case when Result != Team then 1 else 0 end)  loss
FROM matches
GROUP BY Team;

--DROP TABLE Match_Result
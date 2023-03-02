
-- 38- Find Sachin's Milestone Matches-Cricket Analytics with SQL - Advance SQL

--select * from sachin_batting_scores


------------------------------------------------------------


--USING CTE AND UNION

with cte as (
select * ,sum(runs) Over(order by match asc ) as running_sum
from sachin_batting_scores
), cte2 as 
(
select top 1 * from cte where running_sum>=1000 
union all
select top 1 * from cte where running_sum>=5000 
union all
select top 1 * from cte where running_sum>=10000 
)
select ROW_NUMBER() over( order by match ) as 
milestone_number,
floor(running_sum/1000)*1000 as milestone_runs,
innings as milestone_innings, match as milestone_match
from cte2

------------------------------------------------------------

--USING CTE and JOIN with UNION

go
with cte as (
select * ,sum(runs) Over(order by match asc ) as running_sum
from sachin_batting_scores
), cte2 as 
(
select 1 as milestone_number, 1000 as  milestone_runs
union all
select 2 as milestone_number, 5000 as  milestone_runs
union all
select 3 as milestone_number, 10000 as  milestone_runs
union all
select 4 as milestone_number, 15000 as  milestone_runs
)
select 
milestone_number,milestone_runs,
min(innings) as milestone_innings, 
min(match) as milestone_match
from cte2
inner join cte on running_sum>milestone_runs
group by milestone_number,milestone_runs
order by milestone_number,milestone_runs


------------------------------------------------------------



WITH CTE_RUNNING_SCORE AS
(
	SELECT Match,Innings,runs,
	floor(SUM(runs)OVER(ORDER BY Match)/1000.0)*1000 AS milestone_runs
	FROM  sachin_batting_scores
)
SELECT ROW_NUMBER()OVER(ORDER BY milestone_runs) AS milestone_number,
min(Match)AS milestone_match,
min(Innings) AS milestone_innings,milestone_runs
FROM CTE_RUNNING_SCORE
WHERE milestone_runs IN (1000,5000,10000)
GROUP BY milestone_runs




------------------------------------------------------------



WITH t1 AS
(
	SELECT *,SUM(runs) OVER (ORDER BY match) as milestone
	FROM sachin_batting_scores
),
cte2 as 
(
	SELECT match,innings,milestone as runs,
	CASE WHEN milestone>=1000  AND milestone<=4999  THEN 'First'
	WHEN milestone>=5000 AND milestone<=9999 THEN 'Second'
	WHEN milestone>=10000 AND milestone<=14999 THEN 'Third'
	WHEN milestone>=15000 AND milestone<=19999 THEN 'Fourth'
	ELSE 'Zero' END AS milestone_name
	FROM t1
)
select 
Min(floor(runs/1000)*1000) as Milestone_number,
min(match),min(innings),milestone_name
from cte2
WHERE milestone_name!='Zero'
GROUP BY milestone_name
order by Milestone_number


------------------------------------------------------------


with cte as 
(
	select match,innings,runs,
	sum(Runs) over (order by Match) RunningRuns,
	cast( sum(runs) over(order by match )/1000 as int ) as flag
	from sachin_batting_scores
), cte2 as
	(
		select *, DENSE_RANK() Over(Partition by flag order by match ) as rn
		from cte
	)
select row_number() over(order by match ) as Milestone_number ,
match,innings,
floor( RunningRuns/1000) * 1000 as Milestone_runs
from cte2
where flag in (1,5,10,15) and rn=1


------------------------------------------------------------

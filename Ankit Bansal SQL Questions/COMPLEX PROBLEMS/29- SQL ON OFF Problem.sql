
-- 29- SQL ON OFF Problem

--create table event_status
--(
--event_time varchar(10),
--status varchar(10)
--);
--insert into event_status 
--values
--('10:01','on'),('10:02','on'),('10:03','on'),('10:04','off'),('10:07','on'),('10:08','on'),('10:09','off')
--,('10:11','on'),('10:12','off');

------------------------------------------------------------

select * from event_status

------------------------------------------------------------

--USING CTE AND GRP_KEY Concept

go
with cte as (
	select *, lag(status,1,status) over(order by event_time ) as prev_state 
	from event_status
)
,cte2 as (
	select *, sum(case when status='on' and prev_state ='off' then 1 else 0 end ) over(order by event_time) as grp_key 
	from cte
) select
min(event_time) as log_in,
max(event_time) as log_out,
count(1)-1 as cnt
from cte2
group by grp_key


------------------------------------------------------------

--USING CTE AND CASE WHEN Concept

go
WITH CTE_RANK AS(
		SELECT event_time,status,DENSE_RANK() OVER(ORDER BY event_time ASC) AS row_no,
		DENSE_RANK()OVER(PARTITION BY status ORDER BY event_time) AS status_rn
		FROM event_status 
		--order by event_time
	)
	,CTE_DIFF AS(
		SELECT *,CASE WHEN status='on' THEN (row_no-status_rn) ELSE (status_rn-1) END AS diff
		FROM CTE_RANK
		--order by row_no
	)
SELECT min(event_time)AS login,max(event_time) AS logout,COUNT(*)-1 AS cnt
FROM CTE_DIFF
GROUP BY diff

----------------------REVISION--------------------------------------


select * from event_status
go

with cte as (
	select *,ROW_NUMBER() over(order by event_time ) as rn
	,DENSE_RANK() Over ( partition by status order by event_time ) as drn
	from event_status
	)	
, cte2 as (
	select * , case when status ='off' then lag(rn-drn) over(order by event_time) else rn-drn end as grpkey 
	from cte
	)
select min(event_time) as log_in, max(event_time) as log_out, count(1)-1 as cnt
from cte2
group by grpkey

------------------------------------------------------------


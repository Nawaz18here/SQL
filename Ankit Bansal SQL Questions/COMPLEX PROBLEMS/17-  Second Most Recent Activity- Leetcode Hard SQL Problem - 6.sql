
-- 17-  Second Most Recent Activity- Leetcode Hard SQL Problem - 6 | SQL Window Analytical Functions

--create table UserActivity
--(
--username      varchar(20) ,
--activity      varchar(20),
--startDate     Date   ,
--endDate      Date
--);

--insert into UserActivity values 
--('Alice','Travel','2020-02-12','2020-02-20')
--,('Alice','Dancing','2020-02-21','2020-02-23')
--,('Alice','Travel','2020-02-24','2020-02-28')
--,('Bob','Travel','2020-02-11','2020-02-18');

------------------------------------------------------------

with cte_activity as 
(
select *,dense_rank() over(partition by username order by enddate) as rn,
count(1) over(partition by username) as activity_cnt
from UserActivity
)
select * from
cte_activity 
where rn = case when activity_cnt>1 then 2 else 1 end  
-- where rn = 2 or activity_cnt=1 


------------------------------------------------------------

--USING LEAD AND LAG

go
with cte as (
select *,dense_rank() over(partition by username order by enddate) as rn,
lead(activity) over(partition by username order by startdate) as lead_activity
,lag(activity) over(partition by username order by startdate) as lag_activity
from UserActivity
) 
select * from cte
where rn=2 or ( lead_activity is null and lag_activity is null )


------------------------------------------------------------




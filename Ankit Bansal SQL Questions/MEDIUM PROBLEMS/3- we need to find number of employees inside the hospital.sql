
-- we need to find number of employees inside the hospital. I will solve this problem with 3 methods:

--create table hospital ( emp_id int
--, action varchar(10)
--, time datetime);

--insert into hospital values ('1', 'in', '2019-12-22 09:00:00');
--insert into hospital values ('1', 'out', '2019-12-22 09:15:00');
--insert into hospital values ('2', 'in', '2019-12-22 09:00:00');
--insert into hospital values ('2', 'out', '2019-12-22 09:15:00');
--insert into hospital values ('2', 'in', '2019-12-22 09:30:00');
--insert into hospital values ('3', 'out', '2019-12-22 09:00:00');
--insert into hospital values ('3', 'in', '2019-12-22 09:15:00');
--insert into hospital values ('3', 'out', '2019-12-22 09:30:00');
--insert into hospital values ('3', 'in', '2019-12-22 09:45:00');
--insert into hospital values ('4', 'in', '2019-12-22 09:45:00');
--insert into hospital values ('5', 'out', '2019-12-22 09:40:00');

Select * from hospital
go 


-- USING WINDOW FUNCTION 

--with cte as (
--	select *,
--	--Case when action = 'out' then LEAD(time) Over(Partition by emp_id order by time desc ) end as Lead_in
--	DENSE_RANK() Over(Partition by emp_id order by time desc ) as Dense_Rnk
--	from hospital 
--)
--select count(emp_id) as Total_Cnt_Emp 
--from cte c
--where c.action='in' and c.Dense_Rnk=1
--group by action


------------------------------------------------------------------

-- USING CTE 

--With cte as 
--(
--Select emp_id,
--MAX(case when action='in' then time end) as intime,
--Max(case when action='out' then time end )as outtime
--from hospital
--group by emp_id
--)
--Select * from cte c
--where c.intime>c.outtime or c.outtime is null

------------------------------------------------------------------

-- USING GROUP BY  

--Select emp_id,
--MAX(case when action='in' then time end) as intime,
--Max(case when action='out' then time end )as outtime
--from hospital
--group by emp_id
--HAVING MAX(case when action='in' then time end) > MAX(case when action='out' then time end)
--or MAX(case when action='out' then time end) is null

------------------------------------------------------------------

-- USING JOIN  

--with intime_cte as (
--	Select emp_id, Max(time) as intime
--	from hospital
--	where action='in'
--	group by emp_id
--),  outtime_cte as (
--	Select emp_id, Max(time) as outtime
--	from hospital
--	where action='out'
--	group by emp_id
--)
--Select * from intime_cte c1
--left join outtime_cte c2 on c1.emp_id= c2.emp_id
--where c1.intime>c2.outtime or c2.outtime is null



------------------------------------------------------------------

-- USING CTE BEST THINKING APPROACH

with all_latest_time as 
(
	Select emp_id,Max(time) as all_latest_out_time from hospital
	group by emp_id
), only_latest_intime as 
(
	Select emp_id,Max(time) only_latest_in_time  from hospital
	where action='in'
	group by emp_id 
)
Select * from all_latest_time c1
inner join only_latest_intime c2 on c1.emp_id = c2. emp_id
where c1.all_latest_out_time=c2.only_latest_in_time


------------------------------------------------------------------




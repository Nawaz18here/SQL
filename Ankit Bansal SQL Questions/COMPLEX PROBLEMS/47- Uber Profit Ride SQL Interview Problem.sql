
-- 47- Uber Profit Ride SQL Interview Problem
/*
Write a query to print total rides and profit rides
for eacj driver

profit ride: when end location of current ride is
same as start location of next ride

*/

--------------------------------------------------------------

--create table drivers(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));
--insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
--insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
--insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');

--------------------------------------------------------------

select * from drivers

--------------------------------------------------------------

--USING CTE & SUM FUNCTION

go
with cte_profit as (
	select * 
	,lag(end_loc,1,end_loc) over(partition by id order by
	start_time,end_time ) as prev_loc
	from drivers
	)
select id,count(1) as total_rides
, sum(case when start_loc = prev_loc then 1 else 0 end )as profit_ride
from cte_profit
group by id


--------------------------------------------------------------

-- USING SELF JOIN

go
with start_ride as (
	select *,row_number() over(partition by id
	order by start_time,end_time) as rownum 
	from drivers 
)
select d1.id,
count(1) as total_rides,count(d2.id) as profit_rides 
from start_ride d1
left join start_ride d2
on d1.id = d2.id and d1.end_loc = d2.start_loc
and d1.rownum  + 1 = d2.rownum
group by d1.id



--------------------------------------------------------------


-- 20 - Consecutive Empty Seats - SQL Interview Questions
--------------------------------------------------------------

--create table bms (seat_no int ,is_empty varchar(10));
--insert into bms values
--(1,'N')
--,(2,'Y')
--,(3,'N')
--,(4,'Y')
--,(5,'Y')
--,(6,'Y')
--,(7,'N')
--,(8,'Y')
--,(9,'Y')
--,(10,'Y')
--,(11,'Y')
--,(12,'N')
--,(13,'Y')
--,(14,'Y');


--------------------------------------------------------------


 /* 1. In this solution , we are defining three consecutives
 seat are empty */

go
with cte as (
	select *, ROW_NUMBER() Over(order by seat_no ) as rownum,
	seat_no -   ROW_NUMBER() Over(order by seat_no )  as flag
	from bms
	where is_empty = 'Y'
)
, cte2 as (
	select *, count(1) over(partition by flag ) as cnt
	from cte
)
select * from cte2 where cnt>=3


--------------------------------------------------------------


-- USING LEAD / LAG 

go
with cte as (
select *
	,lag(is_empty,1) over(order by seat_no) as prev_1
	,lag(is_empty,2) over(order by seat_no) as prev_2
	,lead(is_empty,1) over(order by seat_no) as lead_1
	,lead(is_empty,1) over(order by seat_no) as lead_2
	from bms
)
select * from cte
where (is_empty='Y' and lead_1 ='Y' and lead_2 ='Y')
or ( is_empty='Y' and lead_1 ='Y' and prev_1 ='Y')
or ( is_empty='Y' and prev_1 ='Y' and prev_2 ='Y')


--------------------------------------------------------------

--USING ADVANCE AGGREGATION

select * from bms

go
with cte as (
select *
,sum(case when is_empty='Y' then 1 end) 
over(order by seat_no rows between current row and 2 following
) as next_2
,sum(case when is_empty='Y' then 1 end) 
over(order by seat_no rows between 2 preceding and current row
) as prev_2
,sum(case when is_empty='Y' then 1 end) 
over(order by seat_no rows between 1 preceding and 1 following
) as prev_next_1
from bms
)
select * from cte
where (next_2 = 3) or (prev_2=3) or (prev_next_1=3)


--------------------------------------------------------------



-- 10- Sucess-Fail Continuous Allignment - An Awesome Tricky SQL Logic | Complex SQL 10

--create table tasks (
--date_value date,
--state varchar(10)
--);

--insert into tasks  values ('2019-01-01','success'),('2019-01-02','success'),('2019-01-03','success'),('2019-01-04','fail')
--,('2019-01-05','fail'),('2019-01-06','success')

------------------------------------------------------------


select * from tasks
go

with cte as 
	(
		select *, Row_number() Over(order by date_value) as rown,
		Row_number() Over(partition by state order by date_value ) as dns,
		Row_number() Over(order by date_value)- Row_number() Over(partition by state order by date_value ) as diff
		from tasks
	)
select min(date_value) as start_date, max(date_value) as end_date, state
from cte
group by state,diff

------------------------------------------------------------

select * from tasks
go



with cte as (
select *, row_number() over ( partition by state order by date_value ) as Rn
, DATEADD(day, -1* row_number() over (partition by state  order by date_value ) , date_value) as new_date
from tasks
)
select min(date_value) as start_date, max(date_value) as end_date, state
from cte
group by state,new_date

------------------------------------------------------------

select * from tasks
go

-- USING LAG

with cte as (
select *,lag(state,1,state) over(order by date_value) as Lag_g from tasks
), cte2 as (
select *, sum(case 
          when (Lag_g = 'success' and state = 'fail') or (Lag_g = 'fail'  and state = 'success') then 1
          else 0
    	End) over(order by date_value) as flag
from cte )
Select 
min(date_value) as start_date,
max(date_value) as end_date,
state
from cte2
group by state,flag



------------------------------------------------------------



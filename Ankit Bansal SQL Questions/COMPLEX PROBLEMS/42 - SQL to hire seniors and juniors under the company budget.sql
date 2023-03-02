
-- 42 - SQL to hire seniors and juniors under the company budget

--create table candidates (
--emp_id int,
--experience varchar(20),
--salary int
--);
--delete from candidates;
--insert into candidates values
--(1,'Junior',10000),(2,'Junior',15000),(3,'Junior',40000),(4,'Senior',16000),(5,'Senior',20000),(6,'Senior',50000);

--------------------------------------------------------------

--USING Multiple CTEs 
go
with cte as (
	select *,
	sum(salary) over( partition by experience
	order by experience desc, emp_id ) 
	as running_sum
	from candidates
)
,cte2 as (
	select *,
	case when running_sum > 70000 then 0 else 1 end as flag
	from cte
)
,cte3 as (
	select *,sum(salary) over( 
	order by experience desc, emp_id ) 
	as running_sum2
	from cte2
	where flag=1 
)
select * from cte3 where running_sum2 < 70000

--------------------------------------------------------------

-- GOOD APPROACH 

with cte as (
select *,
	sum(salary) over(
	partition by experience order by experience desc, emp_id ) as running_sum
	from candidates
)
, senior as (
	select * from cte where experience = 'Senior' and running_sum<70000
)
,juniors as (
select * from cte where experience = 'Junior' and running_sum<70000 - ( Select sum(salary) from senior)
)
select * from senior
union all
select * from juniors


--------------------------------------------------------------

-- GODO APPROACH 2 

with senior_cte as (select *,sum(salary) over(order by salary) as rn_sum_sen
                    from candidates where experience = 'Senior'),
     junior_cte as (select *,sum(salary) over(order by salary) as rn_sum_jun
                    from candidates where experience = 'Junior')
                    
select emp_id,experience,salary from senior_cte where rn_sum_sen<70000
union all
select emp_id,experience,salary from junior_cte where rn_sum_jun<(select 70000-sum(salary) from senior_cte where rn_sum_sen<70000)

--------------------------------------------------------------

--USING Multiple CTEs 

with cte as (
	select *,
	sum(salary) over(
	partition by experience order by experience desc, emp_id ) 
	as running_sum, 70000 as budget_salary
	from candidates
)
,cte2 as (
select *,
sum(salary) over( order by experience desc, emp_id ) 
	as running_sum_2
	from cte
where budget_salary >= running_sum
)
select * from cte2 where budget_salary >= running_sum_2


--------------------------------------------------------------


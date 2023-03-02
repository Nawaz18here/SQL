
------ 11- Print Highest and Lowest salary employees in Each Department

----script:
--create table employee 
--(
--emp_name varchar(10),
--dep_id int,
--salary int
--);
--delete from employee;
----drop table employee

--insert into employee values 
--('Siva',1,30000),('Ravi',2,40000),
--('Prasad',1,50000),('Sai',2,20000)

--insert into employee values 
--('Pallo',3,45000),('Shyam',2,40000),
--('John',1,30000),('Khan',3,100000),
--('Hari',1,7000),('Shyam',4,40000)

--------------------------------------------------------------

select * from employee order by dep_id,salary desc
go

--USING WINDOW FUNCTION AND SUBQUERY

select 
	dep_id,
	MAX(case when max_salary = salary then 
	emp_name else null end ) emp_name_max_salary,
	MAX(case when min_salary = salary then 
	emp_name else null end) emp_name_min_salary
from
	(
		select *,
		Max(salary) Over(Partition by dep_id) as Max_salary,
		Min(salary) Over(Partition by dep_id) as Min_salary
		from employee
	) a
group by dep_id


--------------------------------------------------------------
-- Tried creating two cte but we can do it with one cte also which i have done below

go
with cte_max as
(
	select *,
	Dense_rank() Over(Partition by dep_id order by salary desc,emp_name)
	as Dns_max_rnk
	from employee 
), cte_min as 
(
	select *,
	Dense_rank() Over(Partition by dep_id order by salary asc,emp_name)
	as Dns_min_rnk
	from employee
)
select c1.dep_id, 
MAX(case when Dns_max_rnk=1 then c1.emp_name else null end) as
emp_name_max_salary ,
MIN(case when Dns_min_rnk=1 then c2.emp_name else null end) as
emp_name_min_salary
from cte_max c1, cte_min c2
where c1.dep_id = c2.dep_id
group by c1.dep_id


------------------------------------------------------------

--USING 1 CTE and Max Function 

with cte as
(
	select *,
	Dense_rank() Over(Partition by dep_id order by salary desc,emp_name)
	as Dns_max_rnk,
	Dense_rank() Over(Partition by dep_id order by salary asc,emp_name)
	as Dns_min_rnk
	from employee 
)
select c1.dep_id, 
MAX(case when Dns_max_rnk=1 then c1.emp_name else null end) as
emp_name_max_salary ,
MIN(case when Dns_min_rnk=1 then c1.emp_name else null end) as
emp_name_min_salary
from cte c1 
group by c1.dep_id


------------------------------------------------------------



--select * from employee order by dep_id,salary desc
--go

-- USING SUBUERY and MAX Function

Select 
	b.dep_id, 
	Max(case when b.salary = a.max_salary then emp_name else null end ) as max_salary_emp_name ,
	Max(case when b.salary = a.min_salary then emp_name else null end ) as min_salary_emp_name 
from 
	(
		select dep_id, max(salary) as max_salary, min(salary) as min_salary
		from employee
		group by dep_id
	) a
inner join employee b on a.dep_id = b.dep_id --where a.salary= b.salary
group by b.dep_id

--------------------------------------------------------------

SELECT DISTINCT dep_id,-- salary, emp_name,
first_value(emp_name) OVER (partition By dep_id ORDER BY salary DESC ) as max_salary_employee
,last_value(emp_name) OVER (partition By dep_id ORDER BY salary DESC Range between unbounded preceding and unbounded following ) 
as min_salary_employee
FROM employee;




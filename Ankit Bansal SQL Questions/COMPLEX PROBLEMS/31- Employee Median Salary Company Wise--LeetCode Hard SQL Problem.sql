

--31- employeeC Median Salary Company Wise--LeetCode Hard SQL Problem |

--create table employeeC 
--(
--emp_id int,
--company varchar(10),
--salary int
--);

--insert into employeeC values (1,'A',2341)
--insert into employeeC values (2,'A',341)
--insert into employeeC values (3,'A',15)
--insert into employeeC values (4,'A',15314)
--insert into employeeC values (5,'A',451)
--insert into employeeC values (6,'A',513)
--insert into employeeC values (7,'B',15)
--insert into employeeC values (8,'B',13)
--insert into employeeC values (9,'B',1154)
--insert into employeeC values (10,'B',1345)
--insert into employeeC values (11,'B',1221)
--insert into employeeC values (12,'B',234)
--insert into employeeC values (13,'C',2345)
--insert into employeeC values (14,'C',2645)
--insert into employeeC values (15,'C',2645)
--insert into employeeC values (16,'C',2652)
--insert into employeeC values (17,'C',65);

------------------------------------------------------------

--2 5 7 8 9 --7

--2 5 7 8 9 10 --(7+8)/2= 7.5

select * from employeeC


------------------------------------------------------------

--USING COUNT and CTE

go
with cte_med as
(
	select *
	, row_number() Over(partition by company order by salary )
	as rn_asc
	, count(1) Over(partition by company )
	as cnt_emp
	from employeeC
	--order by company, salary
)
select --*, cnt_emp*1.0/2,cnt_emp*1.0/2+1
company,avg(salary) as median_salary
from cte_med
where rn_asc between cnt_emp*1.0/2 and cnt_emp*1.0/2+1
group by company




------------------------------------------------------------

--USING FLOOR AND CEILING ( BEST )

select (6+1)*1.0/2
select floor( (6+1)*1.0/2 )
select ceiling( (6+1)*1.0/2 )


with cte as
(
select *,
ROW_NUMBER() over(partition by company order by salary) as rn
,count(1) over(partition by company) as cn
from employeeC
)
select company,avg(salary) as med
from cte
where rn in (floor((cn+1)*1.0/2), ceiling((cn+1)*1.0/2))
group by company


----------------------PRACTICE--------------------------------------

go
with cte as (
	select *,ROW_NUMBER() over(partition by company order by salary) as rn,
	count(1) over(partition by company ) as cnt
	from employeeC
)
Select company,avg(salary) as median_sal
from cte
where rn in ( floor((cnt+1)*1.0/2), ceiling((cnt+1)*1.0/2) )
group by company




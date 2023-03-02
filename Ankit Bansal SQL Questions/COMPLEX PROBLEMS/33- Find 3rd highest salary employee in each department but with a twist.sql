
-- 33-  find 3rd highest salary employee in each department but with a twist

-- Incase there are less than 3 emp in a dep then return
--emp with lowest salary in that dep

--CREATE TABLE [empQ](
-- [emp_id] [int] NULL,
-- [emp_name] [varchar](50) NULL,
-- [salary] [int] NULL,
-- [manager_id] [int] NULL,
-- [emp_age] [int] NULL,
-- [dep_id] [int] NULL,
-- [dep_name] [varchar](20) NULL,
-- [gender] [varchar](10) NULL
--) ;
--insert into empQ values(1,'Ankit',14300,4,39,100,'Analytics','Female')
--insert into empQ values(2,'Mohit',14000,5,48,200,'IT','Male')
--insert into empQ values(3,'Vikas',12100,4,37,100,'Analytics','Female')
--insert into empQ values(4,'Rohit',7260,2,16,100,'Analytics','Female')
--insert into empQ values(5,'Mudit',15000,6,55,200,'IT','Male')
--insert into empQ values(6,'Agam',15600,2,14,200,'IT','Male')
--insert into empQ values(7,'Sanjay',12000,2,13,200,'IT','Male')
--insert into empQ values(8,'Ashish',7200,2,12,200,'IT','Male')
--insert into empQ values(9,'Mukesh',7000,6,51,300,'HR','Male')
--insert into empQ values(10,'Rakesh',8000,6,50,300,'HR','Male')
--insert into empQ values(11,'Akhil',4000,1,31,500,'Ops','Male')




--------------------------------------------------------------


with cte as (
	select *,
	dense_rank() over(partition by dep_name order by salary
	desc) as drn_desc
	,count(1) over(partition by dep_name ) as dep_emp_count
	from empQ
	)
select * from cte
where drn_desc = case when dep_emp_count < 3 then dep_emp_count
else 3 end 


--------------------------------------------------------------


WITH CTE_RANK AS(
SELECT *,DENSE_RANK()OVER(PARTITION BY dep_name ORDER BY salary DESC) AS rn_desc,
DENSE_RANK()OVER(PARTITION BY dep_name ORDER BY salary ASC) AS rn_asc,
COUNT(*)OVER(PARTITION BY dep_name) AS cnt_employee_dept
FROM empQ
),
 CTE AS(
SELECT emp_id,emp_name,dep_name,dep_id,
(CASE WHEN cnt_employee_dept>=3 and rn_desc=3 THEN salary
WHEN cnt_employee_dept<3 and rn_asc=1 THEN salary 
END) AS salary
FROM CTE_RANK)
SELECT * FROM CTE
WHERE salary IS NOT NULL

--------------------------------------------------------------

--Metod 1 with 2 cte

with my_cte as(

select *, DENSE_RANK() over(partition by dep_name order by salary desc ) as dr from empQ)
,third_high as (
select * from my_cte where dr = 3
)
,
lowest as
(select x.emp_id,x.emp_name,x.salary, x.manager_id,x.emp_age,x.dep_id, x.dep_name, x.gender,x.dr from 
(select *, DENSE_RANK() over(partition by dep_name order by salary asc) as dr_sal from my_cte 
where dep_name in (select dep_name from my_cte group by dep_name having count(1) < 3)  ) as x where dr_sal = 1
)
select * from lowest
union all
select * from third_high;

--------------------------------------------------------------


---Method - 2 with case statement 
with my_cte as (
select *,
case when count(1) over(partition by dep_id )>=3 
and DENSE_RANK() over(partition by dep_name order by salary desc) = 3 then 1 else 0 end as highest,
case when count(1) over(partition by dep_id ) <3 
and DENSE_RANK() over(partition by dep_name order by salary desc) = count(1) over(partition by dep_id ) then 1 else 0 end as lowest
from empQ)
select
*
from my_cte where highest =1 or lowest =1





--------------------------------------------------------------



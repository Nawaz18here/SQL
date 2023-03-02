--5- Whose salary is same in same department

--CREATE TABLE [emp_salary]
--(
--    [emp_id] INTEGER  NOT NULL,
--    [name] NVARCHAR(20)  NOT NULL,
--    [salary] NVARCHAR(30),
--    [dept_id] INTEGER
--);


--INSERT INTO emp_salary
--(emp_id, name, salary, dept_id)
--VALUES(101, 'sohan', '3000', '11'),
--(102, 'rohan', '4000', '12'),
--(103, 'mohan', '5000', '13'),
--(104, 'cat', '3000', '11'),
--(105, 'suresh', '4000', '12'),
--(109, 'mahesh', '7000', '12'),
--(108, 'kamal', '8000', '11');



select * from emp_salary
order by dept_id


--USING DENSE_RANK and counting the no of DnsRnk
with CTE as 
(
	Select *,DENSE_RANK() Over(Partition by dept_id order by salary ) as DnsRnk
	from emp_salary 
), CTE2 as 
(
	Select *,COUNT(DnsRnk) Over(Partition by Dept_id,DnsRnk) as Flag
	from CTE
)
Select emp_id,name,salary,dept_id from CTE2 where Flag>1 


------------------------------------------------------------------


-- USING WINDOW FUNCTION

Select emp_id,name,salary,dept_id from (
	Select *,COUNT(dept_id) Over(Partition by Dept_id,salary) as Emp_Same_SalCnt
	from emp_salary
	) a where a.Emp_Same_SalCnt>1

------------------------------------------------------------------

--USING INNER JOIN

Select e1.* from emp_salary e1
inner join emp_salary e2 on e1.salary = e2.salary
and e1.dept_id = e2.dept_id and e1.emp_id <> e2.emp_id
go


------------------------------------------------------------------

--USING INNER JOIN 2 

With cte as (
	Select salary,dept_id from emp_salary
	group by salary,dept_id
	having COUNT(Dept_id)>1
)
Select e.* from emp_salary e 
inner join cte c on e.salary=c.salary and e.dept_id = c.dept_id


------------------------------------------------------------------


--USING LEFT JOIN 


With cte as (
	Select salary,dept_id from emp_salary
	group by salary,dept_id
	having COUNT(Dept_id)=1
)
Select e.* from emp_salary e 
left join cte c on e.salary=c.salary and e.dept_id = c.dept_id
where c.dept_id is null





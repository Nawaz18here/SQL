--12. SQL Interview 6 Query ( DEPARTMENT WISE IMPORTANT QUERY )

--Create Table Employee1(
--Empid int not null primary key,
--EmpName varchar(40),
--Salary int,
--DeptId int
--)

--Create table Department1 ( 
--DeptId int not null primary key,
--DeptName nvarchar(100) not null
-- )

--Alter table Employee1 Add constraint FK_ID
--Foreign Key (DeptID) references Department1(DeptID)


-- Insert into Department1 Values (1,'IT')
-- Insert into Department1 Values (2,'HR')
-- Insert into Department1 Values (3,'TECH')
 
-- Insert into Employee1 Values (1001,'Harsh',45000,1)
-- Insert into Employee1 Values (1002,'Aman',49000,2)
-- Insert into Employee1 Values (1003,'Harsh',87000,1)
-- Insert into Employee1 Values (1004,'Aman',16000,3)
-- Insert into Employee1 Values (1005,'Harsh',12300,1)
-- Insert into Employee1 Values (1006,'Priya',98000,2)



 --Insert into Employee1 Values (1001,'Harsh',60000,1)
 --Insert into Employee1 Values (1002,'Aman',50000,1)
 --Insert into Employee1 Values (1003,'Harsh',50000,2)

Select * from Employee1
Select * from Department1

--drop table Employee1
--drop table Department1


--RECORD WITH MAX SALARY
Select distinct top 1 * from Employee1 order by Salary desc
Select * from Employee1 where Salary IN ( Select Max(Salary) from Employee1 ) 

--HIGHEST SALARY
Select Max(Salary) from Employee1

--2nd Highest Salary
Select Max(Salary) from Employee1 where Salary < ( Select Max(Salary) from Employee1 )

Select Distinct Top 1 Salary from (
Select Top 2 Salary from Employee1 Order by Salary DESC) RESULT
Order by Salary ASC

--Reurn EMP NAME, Highest Salary and Department Name
Select E1.EmpName, E1.Salary, D1.DeptNAme from EMployee1 E1
Inner Join Department1 D1
on E1.DeptID=D1.DeptID
Where Salary IN (Select Max(Salary) from Employee1 )


--Return EMP NAME, Highest Salary and Department Name for Each Department

Select E1.EmpName, E1.Salary, D1.DeptNAme from EMployee1 E1
Inner Join Department1 D1
on E1.DeptID=D1.DeptID
Where Salary IN (
Select Max(salary) as MaxSal from Employee1 group by DeptId )


---THIS QUERY IS BETTER PLEASE USE IT ( 1 )
With CTE as (
Select D.DeptName,D.DeptId,Max(E.Salary) as MAXSalDept
from Employee1 E
inner join Department1 D
on E.DeptId=D.DeptId
group by D.DeptID,D.DeptName )

Select e1.EmpName,CTE.DeptName,CTE.MAXSalDept from Employee1 e1
inner join CTE on e1.DeptId=CTE.Deptid where cte.MAXSalDept=e1.Salary


---THIS QUERY IS ONE OF THE BEST PLEASE USE IT ( 2 )
WITH salaries_ranked AS (
    SELECT
        e.DeptId id,
        e.EmpName EmpName,
        e.salary salary,
        RANK() OVER(
            PARTITION BY e.DeptId
            ORDER BY e.salary DESC
        ) srank
    FROM Employee1 e
)
SELECT
    d.DeptName Department,
    sr.EmpName Employee,
    sr.salary
FROM salaries_ranked sr
JOIN Department1 d ON d.DeptId = sr.id
WHERE sr.srank = 1;


--Department TOP 2 Salaries ( IMPORTANT )

Select * from Employee1
Select * from Department1
go 

With C as ( 
Select *,DENSE_RANK() Over (Partition by deptid order by Salary DESC ) as Rnk
from Employee1 )
Select EmpName,Salary,D.DeptNAme from C
inner join Department1 D on C.DeptId = d.DeptId where C.rnk<3

--getNthHighestSalary

Declare @N int
Set @N=3
select distinct salary as getNthHighestSalary from 
(select *, dense_rank() over(order by Salary desc) as rnk from Employee1) a where rnk=@N








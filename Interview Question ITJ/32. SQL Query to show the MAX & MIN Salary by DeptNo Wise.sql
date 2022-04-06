--32. SQL Query to show the MAX & MIN Salary by DeptNo Wise

--Create Table Employee_2(
--EmpName Varchar(30),
--DeptName Varchar(25),
--DeptNo Bigint,
--Salary Bigint);

--Insert into Employee_2 Values('Mark','HR',101,30000);
--Insert into Employee_2 Values('John','Accountant',101,20000);
--Insert into Employee_2 Values('Smith','Analyst',101,25000);
--Insert into Employee_2 Values('Donald','HR',201,40000);
--Insert into Employee_2 Values('James','Analyst',201,22000);
--Insert into Employee_2 Values('Maria','Analyst',201,38000);
--Insert into Employee_2 Values('David','Manager',201,33000);
--Insert into Employee_2 Values('Martin','Analyst',301,22000);
--Insert into Employee_2 Values('Robert','Analyst',301,56000);
--Insert into Employee_2 Values('Michael','Manager',301,34000);
--Insert into Employee_2 Values('Robert','Accountant',301,37000);
--Insert into Employee_2 Values('Michael','Analyst',301,28000);


Select * from Employee_2
go

--USING CTE and MAX,MIN FUNCTION

With CTE as
(
Select *, MAX(Salary) Over ( Partition by DeptNo) as MaxSal,
MIN(Salary) Over ( Partition by DeptNo) as MinSal
from Employee_2
)
Select EmpName,DeptName,DeptNo,Salary
from CTE  C where --C.MaxSal=Salary or C.MinSal=Salary 
SALARY in (MaxSal,MinSal)

--USING CTE and MAX,MIN FUNCTION

With CTE as
(
Select *, DENSE_RANK() Over ( Partition by DeptNo order by Salary DESC) as MinSal
,DENSE_RANK() Over ( Partition by DeptNo order by Salary) as MaxSal,COUNT(EmpName) Over ( Partition by DeptNo) as Cnt
from Employee_2
)
Select EmpName,DeptName,DeptNo,Salary
from CTE  C where --C.MaxSal=cnt or C.MinSal=cnt
MaxSal= 1 or MinSal=1

--Drop table Employee_2
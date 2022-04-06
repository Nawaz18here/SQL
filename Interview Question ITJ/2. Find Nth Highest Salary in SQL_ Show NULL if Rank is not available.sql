--2. How to find Nth Highest Salary in SQL| How to find 2nd Highest Salary in SQL|


--CREATE TABLE Employee(
-- EmpID int ,
-- EmpName varchar(30) ,
-- Salary Bigint ,
-- DeptID int 
--)
--INSERT [dbo].[Employee] ([EmpID], [EmpName], [Salary], [DeptID]) VALUES (1001, N'Mark', 60000, 2)
--INSERT [dbo].[Employee] ([EmpID], [EmpName], [Salary], [DeptID]) VALUES (1002, N'Antony', 40000, 2)
--INSERT [dbo].[Employee] ([EmpID], [EmpName], [Salary], [DeptID]) VALUES (1003, N'Andrew', 15000,1)
--INSERT [dbo].[Employee] ([EmpID], [EmpName], [Salary], [DeptID]) VALUES (1004, N'Peter', 35000, 1)
--INSERT [dbo].[Employee] ([EmpID], [EmpName], [Salary], [DeptID]) VALUES (1005, N'John', 55000, 1)
--INSERT [dbo].[Employee] ([EmpID], [EmpName], [Salary], [DeptID]) VALUES (1006, N'Albert', 25000, 3)
--INSERT [dbo].[Employee] ([EmpID], [EmpName], [Salary], [DeptID]) VALUES (1007, N'Donald', 35000, 3)

Select * from Employee


With CTE as (
Select EmpName,Salary, Dense_Rank() Over ( Order by Salary Desc) as DenseRank
from Employee
)

Select Top 1 EmpName,Salary from CTE where DENSERank = 3

--IT WILL SHOW NULL IF THAT RANK IS NOT AVAILABLE
With CTE as
(
Select salary, Dense_rank() over(order by Salary DESC) as rnk
from Employee
)

select isnull((select top 1 salary from cte where rnk = 8),null) as  8thHighestSalary


--Drop table Employee

-------------------------------------------------------------------------------------------------------

--4. How to find employees whose salary is  greater than their manager's salary 

--Create Table Employee_Tbl(
--EmpID int,
--EmpName Varchar(20),
--Salary Bigint,
--ManagerId int
--)

--Insert into Employee_Tbl Values (101,'David',55000,104)
--Insert into Employee_Tbl Values (102,'John',50000,105)
--Insert into Employee_Tbl Values (103,'Andrew',30000,106)
--Insert into Employee_Tbl Values (104,'Calvin',45000,106)
--Insert into Employee_Tbl Values (105,'Kevin',40000,102)
--Insert into Employee_Tbl Values (106,'Victor',70000,Null)

Select * from Employee_Tbl

Select E.EmpName,E.Salary as EMPSAL,M.EmpName as MGRNAME,M.Salary as MGRSAL
from Employee_Tbl E
inner join Employee_Tbl M
on E.ManagerID = M.EmpId
Where E.Salary>M.Salary

--Drop table Employee_Tbl

-------------------------------------------------------------------------------------------------------

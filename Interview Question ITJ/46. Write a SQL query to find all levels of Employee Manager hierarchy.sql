--46. Write a SQL query to find all levels of Employee Manager hierarchy

-------------------------------------------------------------------------
--Create Table Employee_Table(
--EmployeeID int,
--EmployeeName Varchar(30),
--DepartmentID int,
--ManagerID int)


--Insert into Employee_Table Values(1001,'James Clarke',13,1003)
--Insert into Employee_Table Values(1002,'Robert Williams',12,1005)
--Insert into Employee_Table Values(1003,'Henry Brown',11,1004)
--Insert into Employee_Table Values(1004,'David Wilson',13,1006)
--Insert into Employee_Table Values(1005,'Michael Lee',11,1007)
--Insert into Employee_Table Values(1006,'Daniel Jones',Null,1007)
--Insert into Employee_Table Values(1007,'Mark Smith',14,Null)


With Recursive_CTE as (
Select EmployeeID,EmployeeName,ManagerId,0 as EmployeeLevel  from Employee_Table where ManagerId IS NULL

UNION ALL

Select E.EmployeeID,E.EmployeeName,E.ManagerId,(EmployeeLevel+1) as EmployeeLevel from Employee_Table E
INNER JOIN Recursive_CTE R on E.ManagerId=R.EmployeeID Where EmployeeLevel < 5
)
Select * from Recursive_CTE order by EmployeeLevel 
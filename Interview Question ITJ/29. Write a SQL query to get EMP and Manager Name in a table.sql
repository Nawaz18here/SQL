--29. Write a SQL query to get EMP and Manager Name in a table

--Create Table Employee_1(
--EmployeeID Varchar(20),
--EmployeeName Varchar(20),
--ManagerID varchar(20))

--Insert Into Employee_1 Values(100,'Mark',103)
--Insert Into Employee_1 Values(101,'John',104)
--Insert Into Employee_1 Values(102,'Maria',103)
--Insert Into Employee_1 Values(103,'Tom',NULL)
--Insert Into Employee_1 Values(104, 'David',103)

Select E1.Employeename as EmployeeName, E2.EmployeeName as ManagerName
from Employee_1 E1
inner Join Employee_1 E2
on E1.ManagerId= E2.EmployeeID


Select E1.Employeename as EmployeeName, ISNULL(E2.EmployeeName,'Boss') as ManagerName
from Employee_1 E1
left Join Employee_1 E2
on E1.ManagerId= E2.EmployeeID

--drop table Employee_1

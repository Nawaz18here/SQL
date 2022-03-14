--11. QUESTION:

--  Real time example for right join

-- Visit this link for the explanation of question and answer:
-- https://www.youtube.com/watch?v=I2vuxWebeH8&list=PL6n9fhu94yhXcztdLO7i6mdyaegC8CJwR&index=11

-- TABLE SCRIPT


--Create Table DepartmentsE
--(
--     DepartmentID int primary key,
--     DepartmentName nvarchar(50)
--)
--GO

--Create Table EmployeesE
--(
--     EmployeeID int primary key,
--     EmployeeName nvarchar(50),
--     DepartmentID int foreign key references DepartmentsE(DepartmentID)
--)
--GO

--Insert into DepartmentsE values (1, 'IT')
--Insert into DepartmentsE values (2, 'HR')
--Insert into DepartmentsE values (3, 'Payroll')
--Insert into DepartmentsE values (4, 'Admin')
--GO

--Insert into EmployeesE values (1, 'Mark', 1)
--Insert into EmployeesE values (2, 'John', 1)
--Insert into EmployeesE values (3, 'Mike', 1)
--Insert into EmployeesE values (4, 'Mary', 2)
--Insert into EmployeesE values (5, 'Stacy', 2)
--GO


Select * from EmployeesE
Select * from DepartmentsE order by DepartmentName

--RIGHT JOIN
--Select DepartmentName, EmployeeName
--from EmployeesE EA
--Right join DepartmentsE DA
--On EA.DepartmentID= DA. DepartmentID


--Real time example for right join

Select DepartmentName, COUNT(EA.EmployeeID) as COUNT_EMP
From EmployeesE EA
Right Join DepartmentsE DA
On EA.DepartmentID= DA. DepartmentID
Group by DepartmentName
Order by DepartmentName

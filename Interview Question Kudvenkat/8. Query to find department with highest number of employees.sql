--8. QUESTION:

--  SQL Query to find department with highest number of employees

-- Visit this link for the explanation of question and answer:
-- https://www.youtube.com/watch?v=pYMc_hxUfLQ&list=PL6n9fhu94yhXcztdLO7i6mdyaegC8CJwR&index=8

-- TABLE SCRIPT

----SQL Script to create the required tables
--Create Table DepartmentsD
--(
--     DepartmentID int primary key,
--     DepartmentName nvarchar(50)
--)
--GO

--Create Table EmployeesD
--(
--     EmployeeID int primary key,
--     EmployeeName nvarchar(50),
--     DepartmentID int foreign key references DepartmentsD(DepartmentID)
--)
--GO

--Insert into DepartmentsD values (1, 'IT')
--Insert into DepartmentsD values (2, 'HR')
--Insert into DepartmentsD values (3, 'Payroll')
--GO

--Insert into EmployeesD values (1, 'Mark', 1)
--Insert into EmployeesD values (2, 'John', 1)
--Insert into EmployeesD values (3, 'Mike', 1)
--Insert into EmployeesD values (4, 'Mary', 2)
--Insert into EmployeesD values (5, 'Stacy', 3)
--GO


Select * from DepartmentsD
Select * from  EmployeesD


/*Highest Emp- Department Name*/
Select Top 1 DepartmentName, COUNT(*) as Count_Dep
from DepartmentsD DE
Inner Join EmployeesD EE
On EE.DepartmentID= DE.DepartmentID
Group by DepartmentName
Order by Count_dep desc


--If Interviewer ask not to use COUNT() Function
Select Top 1 DepartmentName
from DepartmentsD DE
Inner Join EmployeesD EE
On EE.DepartmentID= DE.DepartmentID
Group by DepartmentName
Order by COUNT(*) desc




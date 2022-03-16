--8. Show Department and their Emp count as well in all respective department

--CREATE TABLE tblEmployee1
--(
--  Id int Primary Key,
--  Name nvarchar(30),
--  Gender nvarchar(10),
--  DepartmentId int
--)

--CREATE TABLE tblDepartment1
--(
-- DeptId int Primary Key,
-- DeptName nvarchar(20)
--)

----Insert data into tblDepartment1 table
--Insert into tblDepartment1 values (1,'IT')
--Insert into tblDepartment1 values (2,'Payroll')
--Insert into tblDepartment1 values (3,'HR')
--Insert into tblDepartment1 values (4,'Admin')

----Insert data into tblEmployee1 table
--Insert into tblEmployee1 values (1,'John', 'Male', 3)
--Insert into tblEmployee1 values (2,'Mike', 'Male', 2)
--Insert into tblEmployee1 values (3,'Pam', 'Female', 1)
--Insert into tblEmployee1 values (4,'Todd', 'Male', 4)
--Insert into tblEmployee1 values (5,'Sara', 'Female', 1)
--Insert into tblEmployee1 values (6,'Ben', 'Male', 3)


Select * from tblEmployee1
Select * from tblDepartment1

-- Using Group by 
-- Show Department which have more than 2 emp in their department and show count as well

Select D.DeptName, Count(T.Id) as TotalEmp
from TblEmployee1 T
join tbldepartment1 D
on T.DepartmentId= D.DeptId
Group by Deptname
Having Count(T.Id) >=2

--Using CTE
With CTE as
(
	Select D.DeptName,T.DepartmentID, Count(T.Id) as TotalEmp
	from TblEmployee1 T
	join tbldepartment1 D
	on T.DepartmentId= D.DeptId
	Group by Deptname, DepartmentID
)

Select DeptName,TotalEmp
from CTE where TotalEmp>=2

--Fetch odd records
Select * from tblemployee1 where Id %2 =1


-- Using Group by Query
--Show Department and their Emp count as well in all respective department

Select D.DeptName, Count(T.Id) as TotalEmp
from TblEmployee1 T
join tbldepartment1 D
on T.DepartmentId= D.DeptId
Group by D.Deptname
Order by Count(T.Id)
--3. INNER JOINS OF TWO TABLES

Create table tblDepartmentA
(
     ID int not null primary key,
     DepartmentName nvarchar(50),
     Location nvarchar(50),
     DepartmentHead nvarchar(50)
)
Go


Create table tblEmployeeA
(
     ID int primary key,
     Name nvarchar(50),
     Gender nvarchar(50),
     Salary int,
     DepartmentId int foreign key references tblDepartmentA(Id)
)
Go

Select A.*,B.DepartmentName
from tblEmployeeA A
inner join tblDepartmentA B
on A.ID=B.ID
--5. 'CASE WHEN' and 'IIF' Function

--Create table EmployeesB
--(
-- Id int primary key identity,
-- Name nvarchar(10),
-- GenderId int
--)
--Go

--Insert into EmployeesB values ('Mark', 1)
--Insert into EmployeesB values ('John', 1)
--Insert into EmployeesB values ('Amy', 2)
--Insert into EmployeesB values ('Ben', 1)
--Insert into EmployeesB values ('Sara', 2)
--Insert into EmployeesB values ('David', 1)
--Go

--CASE WHEN AND IIF FUNCTION

Select *,
Case GenderId when 1 THEN 'MALE' 
when 2 then 'FEMALE' end as GENDERNAME
from EmployeesB

Select *, IIF(GenderID=1,'Male','Female') as GenderName
from EmployeesB



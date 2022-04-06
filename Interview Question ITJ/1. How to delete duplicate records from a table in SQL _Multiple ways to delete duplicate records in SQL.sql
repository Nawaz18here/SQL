--1. How to delete duplicate records from a table in SQL | Multiple ways to delete duplicate records in SQL

--Create Table EmpDetail (
--ID int identity(1,1),
--EmpName varchar(25),
--Departmemt varchar(20),
--Age int,
--Gender char(1),
--Salary Bigint
--)

--Insert into EmpDetail values('James','HR',30,'M',40000)
--Insert into EmpDetail values('James','HR',30,'M',40000)
--Insert into EmpDetail values('James','HR',30,'M',40000)
--Insert into EmpDetail values('John','Finance',32,'M',45000)
--Insert into EmpDetail values('Maria','Admin',28,'M',30000)
--Insert into EmpDetail values('Maria','Admin',28,'M',30000)
--Insert into EmpDetail values('Mark','Account',35,'M',50000)

Select * from EmpDetail

---USING CTE 
With CTE as
( Select *, ROW_Number() Over( Partition by Salary order by EmpName ) as RowNum from EmpDetail )
Delete from CTE where RowNum>1

Select * from EmpDetail

--USING SUB QUERY AND MAX FUNCTION
Delete from EmpDetail where ID NOT IN (
Select  MAX(ID) from EmpDetail
group by EmpName )

--Drop table EmpDetail
-------------------------------------------------------------------------------------------------------

--25. Write a SQL to find Top 2 records from each department 

--Create table Emp_Detail
--(
--EmpName Varchar(25),
--Age int,
--Salary Bigint,
--Department Varchar(20)
--)

--Insert into Emp_Detail Values('James',25,25000,'Admin')
--Insert into Emp_Detail Values('Robert',33,39000,'Admin')
--Insert into Emp_Detail Values('Richard',41,48000,'Admin')
--Insert into Emp_Detail Values('Thomas',28,30000,'Admin')
--Insert into Emp_Detail Values('Tom',40,55000,'Finance')
--Insert into Emp_Detail Values('Donald',35,38000,'Finance')
--Insert into Emp_Detail Values('Sara',32,44000,'Finance')
--Insert into Emp_Detail Values('Mike',28,25000,'HR')
--Insert into Emp_Detail Values('John',35,45000,'HR')
--Insert into Emp_Detail Values('Mary',23,30000,'HR')
--Insert into Emp_Detail Values('David',32,43000,'HR')

With CTE as (
Select *, DENSE_RANK() over(partition by department order by salary desc) as DenseRank
from Emp_Detail )
Select EmpName,Age,Salary,Department
from CTE where CTE.DenseRank<=2

-- DROP TABLE Emp_Detail
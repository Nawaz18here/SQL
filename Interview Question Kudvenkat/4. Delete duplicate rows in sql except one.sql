--4. QUESTION:

-- Deleting all duplicate rows except one from a sql server table.

-- Visit this link for the explanation of question and answer:
-- https://www.youtube.com/watch?v=ynWgSZBoUkU&list=PL6n9fhu94yhXcztdLO7i6mdyaegC8CJwR&index=4

-- TABLE SCRIPT

----SQL Script to create EmployeesD table
--Create table EmployeesD
--(
-- ID int,
-- FirstName nvarchar(50),
-- LastName nvarchar(50),
-- Gender nvarchar(50),
-- Salary int
--)
--GO

--Insert into EmployeesD values (1, 'Mark', 'Hastings', 'Male', 60000)
--Insert into EmployeesD values (1, 'Mark', 'Hastings', 'Male', 60000)
--Insert into EmployeesD values (1, 'Mark', 'Hastings', 'Male', 60000)
--Insert into EmployeesD values (2, 'Mary', 'Lambeth', 'Female', 30000)
--Insert into EmployeesD values (2, 'Mary', 'Lambeth', 'Female', 30000)
--Insert into EmployeesD values (3, 'Ben', 'Hoskins', 'Male', 70000)
--Insert into EmployeesD values (3, 'Ben', 'Hoskins', 'Male', 70000)
--Insert into EmployeesD values (3, 'Ben', 'Hoskins', 'Male', 70000)

Select * from EmployeesD
go 


With Result as (
Select *, Row_number() over ( Partition by Id order by id) as RowNumber
from EmployeesD
)

--Select * from Result where Rownumber>1
Delete from Result where Rownumber>1

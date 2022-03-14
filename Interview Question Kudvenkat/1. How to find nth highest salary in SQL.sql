--1. QUESTION:

--a) How to find nth highest salary in SQL Server using a Sub-Query
--b) How to find nth highest salary in SQL Server using a CTE
--c) How to find the 2nd, 3rd or 15th highest salary

-- Visit this link for the explanation of question and answer:
-- https://www.youtube.com/watch?v=fvPddKyHxpQ&list=PL6n9fhu94yhXcztdLO7i6mdyaegC8CJwR 

-- TABLE SCRIPT

--Create table Employees
--(
--     ID int primary key identity,
--     FirstName nvarchar(50),
--     LastName nvarchar(50),
--     Gender nvarchar(50),
--     Salary int
--)
--GO

--Insert into Employees values ('Ben', 'Hoskins', 'Male', 70000)
--Insert into Employees values ('Mark', 'Hastings', 'Male', 60000)
--Insert into Employees values ('Steve', 'Pound', 'Male', 45000)
--Insert into Employees values ('Ben', 'Hoskins', 'Male', 70000)
--Insert into Employees values ('Philip', 'Hastings', 'Male', 45000)
--Insert into Employees values ('Mary', 'Lambeth', 'Female', 30000)
--Insert into Employees values ('Valarie', 'Vikings', 'Female', 35000)
--Insert into Employees values ('John', 'Stanmore', 'Male', 80000)
--GO


Select * from Employees

-- MY SOLUTION: 

--Highest Salary in Employees Table
Select Max(Salary) as MaxSalary from Employees

--2nd Highest Salary

Select Max( Salary) as '2nd_Highest_Sal' from Employees 
where Salary < ( Select Max(Salary) from Employees )


-- N th Highest Salary Using Sub-Query
Select * from Employees order by salary desc

Select Top 1 Salary From 
			( Select DISTINCT Top 5 Salary from Employees
			  order by Salary DESC 
			  ) Result
order by Salary 


-- N th Highest Salary Using CTE

With Result as (
			Select Salary, DENSE_RANK() Over ( Order by salary desc) as DENSERANK
			from Employees
			) 

Select Top 1 Salary from Result
where Result.DenseRank= 2

Select * from Employees order by salary desc


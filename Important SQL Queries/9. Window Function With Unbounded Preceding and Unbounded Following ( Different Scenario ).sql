--9. Window Function With Unbounded Preceding and Unbounded Following ( Different Scenario )

--Create Table Employees
--(
-- Id int primary key,
-- Name nvarchar(50),
-- Gender nvarchar(10),
-- Salary int
--)
--Go

--Insert Into Employees Values (1, 'Mark', 'Male', 5000)
--Insert Into Employees Values (2, 'John', 'Male', 4500)
--Insert Into Employees Values (3, 'Pam', 'Female', 5500)
--Insert Into Employees Values (4, 'Sara', 'Female', 4000)
--Insert Into Employees Values (5, 'Todd', 'Male', 3500)
--Insert Into Employees Values (6, 'Mary', 'Female', 5000)
--Insert Into Employees Values (7, 'Ben', 'Male', 6500)
--Insert Into Employees Values (8, 'Jodi', 'Female', 7000)
--Insert Into Employees Values (9, 'Tom', 'Male', 5500)
--Insert Into Employees Values (10, 'Ron', 'Male', 5000)
--Go

--Select * from Employees

---- NO PARTITION
Select *,
Avg(Salary) over(Order by Salary rows between unbounded preceding and unbounded following ) as AVGSAL,
Count(Salary) over (Order by Salary rows between unbounded preceding and unbounded following) as COUNTSAL,
SUM(Salary) over ( Order by Salary rows between unbounded preceding and unbounded following ) as SUMSAL
from Employees


-- WITH PARTITION
Select *,
Avg(Salary) over(PARTITION BY GENDER Order by Salary rows between unbounded preceding and unbounded following ) as AVGSAL,
Count(Salary) over (PARTITION BY GENDER Order by Salary rows between unbounded preceding and unbounded following) as COUNTSAL,
SUM(Salary) over (PARTITION BY GENDER Order by Salary rows between unbounded preceding and unbounded following ) as SUMSAL
from Employees

-- WITH PARTITION with RANGE FUNC : Running Total
Select *,
SUM(Salary) over(Order by Salary RANGE between unbounded preceding and Current Row ) as SUMSAL
from Employees

-- WITH PARTITION with ROWS FUNC : Running Total
Select *,
SUM(Salary) over(Order by Salary ROWS between unbounded preceding and Current Row ) as SUMSAL
from Employees



---- 1 preceding and 1 following
Select *,
Avg(Salary) over(Order by Salary rows between 1 preceding and 1 following ) as AVGSAL,
Count(Salary) over (Order by Salary rows between 1 preceding and 1 following) as COUNTSAL,
SUM(Salary) over ( Order by Salary rows between 1 preceding and 1 following ) as SUMSAL
from Employees


-- RANK, DENSE_RANK & ROW_NO FUNCTION
Select Name, Gender,Salary,
RANK() Over (Order by Salary DESC) as [RANK],
DENSE_RANK() OVER ( Order by Salary DESC ) as [DENSE_RANK],
ROW_NUMBER() OVER ( Order by Salary DESC ) as [ROW_NO]
from Employees

--  USING SUBQUERY
Select top 1 Salary from 
	(
		Select distinct top 4 Salary
		from Employees 
		order by Salary DESC
	) as Result
order by Salary 


--USING CTE
With CTE as 
(
Select Name,Salary,DENSE_RANK() Over (Order by Salary DESC) as DENSERANK
from Employees
)
Select top 1 Name,Salary from CTE where CTE.DenseRank= 7


--5. QUESTION:

--  SQL query to find employees hired in last n months

-- Visit this link for the explanation of question and answer:
-- https://www.youtube.com/watch?v=mnJze9kTGYU&list=PL6n9fhu94yhXcztdLO7i6mdyaegC8CJwR&index=5


-- TABLE SCRIPT

----SQL Script to create the table and populate with test data
--Create table EmployeesH
--(
--     ID int primary key identity,
--     FirstName nvarchar(50),
--     LastName nvarchar(50),
--     Gender nvarchar(50),
--     Salary int,
--     HireDate DateTime
--)
--GO

--Insert into EmployeesH values('Mark','Hastings','Male',60000,'5/10/2020')
--Insert into EmployeesH values('Steve','Pound','Male',45000,'4/20/2020') 
--Insert into EmployeesH values('Ben','Hoskins','Male',70000,'4/5/2020')
--Insert into EmployeesH values('Philip','Hastings','Male',45000,'3/11/2020')
--Insert into EmployeesH values('Mary','Lambeth','Female',30000,'3/10/2020')
--Insert into EmployeesH values('Valarie','Vikings','Female',35000,'2/9/2020')
--Insert into EmployeesH values('John','Stanmore','Male',80000,'2/22/2020')
--Insert into EmployeesH values('Able','Edward','Male',5000,'1/22/2020')
--Insert into EmployeesH values('Emma','Nan','Female',5000,'1/14/2020')
--Insert into EmployeesH values('Jd','Nosin','Male',6000,'1/10/2020')
--Insert into EmployeesH values('Todd','Heir','Male',7000,'2/14/2020')
--Insert into EmployeesH values('San','Hughes','Male',7000,'3/15/2020')
--Insert into EmployeesH values('Nico','Night','Male',6500,'4/19/2020')
--Insert into EmployeesH values('Martin','Jany','Male',5500,'5/23/2020')
--Insert into EmployeesH values('Mathew','Mann','Male',4500,'6/23/2020')
--Insert into EmployeesH values('Baker','Barn','Male',3500,'7/23/2020')
--Insert into EmployeesH values('Mosin','Barn','Male',8500,'8/21/2020')
--Insert into EmployeesH values('Rachel','Aril','Female',6500,'9/14/2020')
--Insert into EmployeesH values('Pameela','Son','Female',4500,'10/14/2020')
--Insert into EmployeesH values('Thomas','Cook','Male',3500,'11/14/2020')
--Insert into EmployeesH values('Malik','Md','Male',6500,'12/14/2020')
--Insert into EmployeesH values('Josh','Anderson','Male',4900,'5/1/2020')
--Insert into EmployeesH values('Geek','Ging','Male',2600,'4/1/2020')
--Insert into EmployeesH values('Sony','Sony','Male',2900,'4/30/2020')
--Insert into EmployeesH values('Aziz','Sk','Male',3800,'3/1/2020')
--Insert into EmployeesH values('Amit','Naru','Male',3100,'3/31/2020')


----Select * from EmployeesH order by Hiredate desc

-- Hired in last 5 Months
Select *, Datediff(Month,Hiredate,getdate()) as Diff
from EmployeesH
where  Datediff(Month,Hiredate,getdate())  between 1 and 5



-- Hired in last 90 Days
Select *, Datediff(DAY,Hiredate,getdate()) as Diff
from EmployeesH
where  Datediff(DAY,Hiredate,getdate())  between 1 and 90

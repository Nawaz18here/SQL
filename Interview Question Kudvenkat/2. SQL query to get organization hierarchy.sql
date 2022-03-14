--2. QUESTION:

--Here is the problem definition:
--1. Employees table contains the following columns 
--    a) EmployeeId, 
--    b) EmployeeName 
--    c) ManagerId 
--2. If an EmployeeId is passed, the query should list down the entire organization hierarchy i.e who is the manager of the EmployeeId passed and who is managers manager and so on till full hierarchy is listed.

--For example, 
--Scenario 1: If we pass David's EmployeeId to the query, then it should display the organization hierarchy starting from David.

--Scenario 2: If we pass Lara's EmployeeId to the query, then it should display the organization hierarchy starting from Lara.

-- Visit this link for the explanation of question and answer:
-- https://www.youtube.com/watch?v=Kd3HTph0Mds&list=PL6n9fhu94yhXcztdLO7i6mdyaegC8CJwR&index=2

-- TABLE SCRIPT

--Create table EmployeesM
--(
-- EmployeeID int primary key identity,
-- EmployeeName nvarchar(50),
-- ManagerID int foreign key references EmployeesM(EmployeeID)
--)
--GO

--Insert into EmployeesM values ('John', NULL)
--Insert into EmployeesM values ('Mark', NULL)
--Insert into EmployeesM values ('Steve', NULL)
--Insert into EmployeesM values ('Tom', NULL)
--Insert into EmployeesM values ('Lara', NULL)
--Insert into EmployeesM values ('Simon', NULL)
--Insert into EmployeesM values ('David', NULL)
--Insert into EmployeesM values ('Ben', NULL)
--Insert into EmployeesM values ('Stacy', NULL)
--Insert into EmployeesM values ('Sam', NULL)
--GO

--Update EmployeesM Set ManagerID = 8 Where EmployeeName IN ('Mark', 'Steve', 'Lara')
--Update EmployeesM Set ManagerID = 2 Where EmployeeName IN ('Stacy', 'Simon')
--Update EmployeesM Set ManagerID = 3 Where EmployeeName IN ('Tom')
--Update EmployeesM Set ManagerID = 5 Where EmployeeName IN ('John', 'Sam')
--Update EmployeesM Set ManagerID = 4 Where EmployeeName IN ('David')
--GO

--Select * from EmployeesM

-- SELF JOIN

Select E1.EmployeeId, E1.EmployeeName, ISNULL(E2.EmployeeName, 'No Boss')  as Manager_Name from EmployeesM E1
Left Join EmployeesM E2
on E1.ManagerId= E2.EmployeeID


--MY SOLUTIONS: 

Declare @Id int;
Set @Id= 7;

With EmployeesMCTE as (
		
		Select EmployeeID,	EmployeeName	,ManagerID
		from EmployeesM
		where EmployeeId= @Id


		UNION ALL

		Select M1.EmployeeID,M1.EmployeeName,M1.ManagerID
		from EmployeesM M1
		Join EmployeesMCTE M2
		on M1.EmployeeId= M2.ManagerID


)

Select MT1.EmployeeName, ISNULL( MT2.EmployeeName, 'No Boss') as ManagerName
from EmployeesMCTE MT1
Left join EmployeesMCTE MT2
on MT1.ManagerId= MT2.EmployeeID




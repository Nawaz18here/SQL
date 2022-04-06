----8th QUESTION 

--Write a SQL to find all Employees who earn more than the average salary in their corresponding department.

--CREATE Table Employee
--(
--EmpID INT,
--EmpName Varchar(30),
--Salary Float,
--DeptID INT
--)

--INSERT INTO Employee VALUES(1001,'Mark',60000,2)
--INSERT INTO Employee VALUES(1002,'Antony',40000,2)
--INSERT INTO Employee VALUES(1003,'Andrew',15000,1)
--INSERT INTO Employee VALUES(1004,'Peter',35000,1)
--INSERT INTO Employee VALUES(1005,'John',55000,1)
--INSERT INTO Employee VALUES(1006,'Albert',25000,3)
--INSERT INTO Employee VALUES(1007,'Donald',35000,3)

--Write a SQL to find all Employees who earn more than the average salary in their corresponding department.
Select DeptID,EmpName,Salary from (
Select *,AVG(Salary) OVER ( partition by DEPTID ) as AvgSalbyDEPT from Employee ) as A
Where Salary > A.AvgSalbyDEPT

--Drop table Employee





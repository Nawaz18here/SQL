
-- 43- List Emp with their Manager and Senior Manager 

--create table empC(
--emp_id int,
--emp_name varchar(20),
--department_id int,
--salary int,
--manager_id int,
--emp_age int);

--insert into empC
--values
--(1, 'Ankit', 100,10000, 4, 39);
--insert into empC
--values (2, 'Mohit', 100, 15000, 5, 48);
--insert into empC
--values (3, 'Vikas', 100, 12000,4,37);
--insert into empC
--values (4, 'Rohit', 100, 14000, 2, 16);
--insert into empC
--values (5, 'Mudit', 200, 20000, 6,55);
--insert into empC
--values (6, 'Agam', 200, 12000,2, 14);
--insert into empC
--values (7, 'Sanjay', 200, 9000, 2,13);
--insert into empC
--values (8, 'Ashish', 200,5000,2,12);
--insert into empC
--values (9, 'Mukesh',300,6000,6,51);
--insert into empC
--values (10, 'Rakesh',500,7000,6,50);

------------------------------------------------------------

--USING DOUBLE SELF JOIN

select e1.emp_id as Empid,e1.emp_name as EmpName,
e2.emp_name as Manager_Name,
e3.emp_name as Senior_Manager_Name
from empC e1
inner join empC e2
on e1.manager_id = e2.emp_id
inner join empC e3
on e2.manager_id = e3.emp_id

------------------------------------------------------------


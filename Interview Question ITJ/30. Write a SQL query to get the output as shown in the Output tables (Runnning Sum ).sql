--30. Write a SQL query to get the output as shown in the Output tables (Runnning Sum )

--Create Table Sales1
--(
--Id int,
--Product Varchar(20),
--Sales Bigint
--);

--Insert into Sales1 values(1001,'Keyboard',20)
--Insert into Sales1 values(1002,'Keyboard',25)
--Insert into Sales1 values(1003,'Laptop',30)
--Insert into Sales1 values(1004,'Laptop',35)
--Insert into Sales1 values(1005,'Laptop',40)
--Insert into Sales1 values(1006,'Monitor',45)
--Insert into Sales1 values(1007,'WebCam',50)
--Insert into Sales1 values(1008,'WebCam',55)



Select * from Sales1


Select ID,Product, FIRST_VALUE(Sales) Over(Partition by product order by ID) as Sales_Amt
from Sales1

Select ID,Product, SUM(Sales) Over(Partition by product order by ID) as Sales_Amt
from Sales1






--drop table Sales1
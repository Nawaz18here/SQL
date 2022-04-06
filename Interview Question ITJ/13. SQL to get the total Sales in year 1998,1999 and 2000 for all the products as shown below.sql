-- 13. Write SQL to get the total Sales in year 1998,1999 and 2000 for all the products as shown below

--Create Table Sales (
--ID int,
--Product Varchar(25),
--SalesYear Int,
--QuantitySold Int)

--Insert into Sales Values(1,'Laptop',1998,2500);
--Insert into Sales Values(2,'Laptop',1999,3600);
--Insert into Sales Values(3,'Laptop',2000,4200);
--Insert into Sales Values(4,'Keyboard',1998,2300);
--Insert into Sales Values(5,'Keyboard',1999,4800);
--Insert into Sales Values(6,'Keyboard',2000,5000);
--Insert into Sales Values(7,'Mouse',1998,6000);
--Insert into Sales Values(8,'Mouse',1999,3400);
--Insert into Sales Values(9,'Mouse',2000,4600);

Select * from Sales

--USING CASE STATEMENT

Select 'TotalSales' as TotalSales,
SUM( Case when SalesYear=1998 then QuantitySold else 0 End ) as '1998',
SUM( Case when SalesYear=1999 then QuantitySold else 0 End ) as '1999',
SUM( Case when SalesYear=2000 then QuantitySold else 0 End ) as '2000'
from Sales


--PIVOT METHOD
Select 'TotalSales' as [TotalSales],[1998],[1999],[2000]
from 
( 
Select SalesYear,QuantitySold from Sales
)b 
PIVOT 
(
Max(QuantitySold) 
for SalesYear in ([1998],[1999],[2000])
) as PivotTable


--DROP TABLE Sales

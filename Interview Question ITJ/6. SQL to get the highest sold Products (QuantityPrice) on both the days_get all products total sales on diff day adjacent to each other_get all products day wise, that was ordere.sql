---6th QUESTION
--(a) Write a SQL to get the highest sold Products (Quantity*Price) on both the days 
--(b) Write a SQL to get all product's  total sales on 1st May and 2nd May adjacent to each other
--(c) Write a SQL to get all products day wise, that was ordered more than once


--CREATE TABLE [Order_Tbl](
-- [ORDER_DAY] date,
-- [ORDER_ID] varchar(10) ,
-- [PRODUCT_ID] varchar(10) ,
-- [QUANTITY] int ,
-- [PRICE] int 
--) 

--INSERT INTO [Order_Tbl]  VALUES ('2015-05-01','ODR1', 'PROD1', 5, 5)
--INSERT INTO [Order_Tbl]  VALUES ('2015-05-01','ODR2', 'PROD2', 2, 10)
--INSERT INTO [Order_Tbl]  VALUES ('2015-05-01','ODR3', 'PROD3', 10, 25)
--INSERT INTO [Order_Tbl]  VALUES ('2015-05-01','ODR4', 'PROD1', 20, 5)
--INSERT INTO [Order_Tbl]  VALUES ('2015-05-02','ODR5', 'PROD3', 5, 25)
--INSERT INTO [Order_Tbl]  VALUES ('2015-05-02','ODR6', 'PROD4', 6, 20)
--INSERT INTO [Order_Tbl]  VALUES ('2015-05-02','ODR7', 'PROD1', 2, 5)
--INSERT INTO [Order_Tbl]  VALUES ('2015-05-02','ODR8', 'PROD5', 1, 50)
--INSERT INTO [Order_Tbl]  VALUES ('2015-05-02','ODR9', 'PROD6', 2, 50)
--INSERT INTO [Order_Tbl]  VALUES ('2015-05-02','ODR10','PROD2', 4, 10)

Select * from Order_Tbl
Go

--(a) Write a SQL to get the highest sold Products (Quantity*Price) on both the days 

Select Order_day,Product_id, (Quantity * Price ) as SoldAMOUNT from 
(
Select *,DENSE_RANK() over ( Partition by Order_Day Order by (Quantity * Price ) DESC ) as SlDQnt from Order_Tbl
) as A
Where SlDQnt=1
-------------------------------------------------------------------------------------------------------
--(b) Write a SQL to get all product's  total sales on 1st May and 2nd May adjacent to each other


Select * from Order_Tbl
Go

Select B2.Product_ID, ISNULL(A2.SoldAMOUNTDay1, 0 ) as SoldAMOUNTDay1 , B2.SoldAMOUNTDay2 from 
(
Select ORDER_DAY,Product_ID, SUM(Quantity * Price ) as SoldAMOUNTDay2
from Order_Tbl Where ORDER_DAY='2015-05-02' Group by Product_ID,ORDER_DAY ) as B2
LEFT JOIN 
(
Select ORDER_DAY,Product_ID, SUM(Quantity * Price ) as SoldAMOUNTDay1
from Order_Tbl Where ORDER_DAY='2015-05-01' Group by Product_ID,ORDER_DAY ) as A2
on B2.Product_ID=A2.Product_ID

Select Product_ID,
SUM( CASE WHEN ORDER_DAY= '2015-05-01' then (Quantity * Price) else 0 END ) as SoldAMOUNTDay1,
SUM( CASE WHEN ORDER_DAY= '2015-05-02' then (Quantity * Price) else 0 END ) as SoldAMOUNTDay2
from Order_Tbl Group by Product_ID

-------------------------------------------------------------------------------------------------------

--(c) Write a SQL to get all products day wise, that was ordered more than once

Select Order_Day,Product_id--, COUNT(*) as OrderedCount
from Order_Tbl Group by Product_ID,Order_Day
Having COUNT(*)>1

--DROP TABLE Order_Tbl
-------------------------------------------------------------------------------------------------------
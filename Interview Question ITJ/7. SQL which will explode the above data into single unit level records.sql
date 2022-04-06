----7th QUESTION 
--Write a SQL which will explode the above data into single unit level records 

--CREATE TABLE Order_Tbl(
-- ORDER_ID varchar(10),
-- PRODUCT_ID varchar(10),
-- QUANTITY int);

--INSERT INTO Order_Tbl(ORDER_ID,PRODUCT_ID,QUANTITY)
--VALUES('odr1','prd1',5),('odr2','prd2',1),('odr3','prd3',3);

--select * from Order_Tbl

With CTE As (

--Anchor Part
Select Order_id,Product_id,1 as Quantity, 1 as CNT
from Order_Tbl

UNION all

-- Recursive Part 
Select C.Order_id,C.Product_id, C.Quantity, C.CNT+1
from Order_Tbl T
Inner join CTE C
on T.Order_id=C.Order_id
where C.CNT<T.Quantity

)

SELECT ORDER_ID,PRODUCT_ID,Quantity FROM CTE
order by ORDER_ID,PRODUCT_ID


--DROP TABLE Order_Tbl
-------------------------------------------------------------------------------------------------------
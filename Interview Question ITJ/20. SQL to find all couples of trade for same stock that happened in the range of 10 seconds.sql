--20.  Write SQL to find all couples of trade for same stock that happened in the range of 10 seconds and having price difference by more than 10 %.
--Output result should also list the percentage of price difference between the 2 trade

--Create Table Trade_tbl(
--TRADE_ID varchar(20),
--Trade_Timestamp time,
--Trade_Stock varchar(20),
--Quantity int,
--Price Float
--)

--Insert into Trade_tbl Values('TRADE1','10:01:05','ITJunction4All',100,20)
--Insert into Trade_tbl Values('TRADE2','10:01:06','ITJunction4All',20,15)
--Insert into Trade_tbl Values('TRADE3','10:01:08','ITJunction4All',150,30)
--Insert into Trade_tbl Values('TRADE4','10:01:09','ITJunction4All',300,32)
--Insert into Trade_tbl Values('TRADE5','10:10:00','ITJunction4All',-100,19)
--Insert into Trade_tbl Values('TRADE6','10:10:01','ITJunction4All',-300,19)

With CTE_Trade as (
Select * from Trade_tbl )
Select A.Trade_Id as FirstTrade,B.Trade_Id as SecondTrade, floor(ABS( ((B.Price-A.Price)*100/A.Price) )) as Diff
from CTE_Trade A
Inner join CTE_Trade B
on A.Trade_Id<B.Trade_Id where DATEDIFF(SECOND,A.Trade_Timestamp,B.Trade_Timestamp)<=10
and ABS( ((B.Price-A.Price)*100/A.Price))>=10  order by FirstTrade

SELECT first, second, floor(abs((price_2-price_1)*100/price_1)) as 'Price_Diff' FROM
(SELECT * FROM
(select trade_ID AS 'FIRST',TRADE_TIMESTAMP AS 'TRADE_TIMESTAMP_1',PRICE AS 'PRICE_1' FROM trade_tbl) A INNER JOIN
(select trade_ID AS 'SECOND', TRADE_TIMESTAMP AS 'TRADE_TIMESTAMP_2',PRICE AS 'PRICE_2' FROM trade_tbl) B
ON A.FIRST < B.SECOND) C where DATEDIFF(second ,TRADE_TIMESTAMP_1,TRADE_TIMESTAMP_2) <=10
and abs((price_2-price_1)*100/price_1) >= 10 order by first

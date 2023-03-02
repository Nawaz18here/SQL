
-- 9- Repeat Purchase on different days

--create table Purchases
--(
--user_id int ,
--product_id int,
--quantity int,
--purchase_date datetime -- DD/MM/YYYY
--);
--INSERT INTO Purchases values(333,1122,8,'06/02/2022 14:56:03');
--INSERT INTO Purchases values(333,1122,10,'06/02/2022 2:00:00');
--INSERT INTO Purchases values(333,1122,9,'06/02/2022 1:00:00');
--INSERT INTO Purchases values(536,1435,10,'03/02/2022 14:56:03');
--INSERT INTO Purchases values(536,3223,6,'01/11/2022 14:56:03');
--INSERT INTO Purchases values(536,3223,5,'03/02/2022 14:56:03');
--INSERT INTO Purchases values(827,1234,5,'06/02/2022 14:56:03');
--INSERT INTO Purchases values(827,1234,5,'09/02/2022 14:56:03');
--INSERT INTO Purchases values(827,7890,5,'11/02/2022 14:56:03');
--INSERT INTO Purchases values(827,7890,5,'12/02/2022 14:56:03');

------------------------------------------------------------
select * from Purchases
go

-- USING CTE & LEAD WINDOW FUNCTION

with cte as (
	select *
		,lead(purchase_date) over(Partition by user_id,product_id
		order by purchase_date) as Lead_Pur_Date
	from Purchases
	)
	select COUNT(Distinct user_id ) as Usr_Num
	from CTE
	where datediff(day,purchase_date,Lead_Pur_Date) <>0

------------------------------------------------------------

select * from Purchases
go

-- USING SUBUERY AND HAVING

Select COUNT(DISTINCT[user_id]) as Usr_num 
from
	(
		select 
		[user_id],product_id,
		COUNT(DISTINCT CONVERT(DATE,Purchase_date)) as Cnt
		from Purchases
		group by [user_id],product_id
		Having 
		COUNT(DISTINCT CONVERT(DATE,Purchase_date)) >1
	) a



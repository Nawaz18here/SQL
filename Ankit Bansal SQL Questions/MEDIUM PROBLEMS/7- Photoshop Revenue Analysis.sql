
-- 7- Photoshop Revenue Analysis

--create table adobe_transactions
--( customer_id int,
--product varchar(50),
--revenue int
--)

--insert into adobe_transactions 
--values(123,'Photoshop',50),
--(123,'Premier Pro',100),
--(123,'After Effects',50),
--(234,'Illustrator',200),
--(234,'Premier Pro',100)


Select * from adobe_transactions 
go

--USING CTE

with cte as 
(
		select distinct customer_id from adobe_transactions
		where product in ('photoshop')
	) 
Select a.customer_id,sum(revenue) as Sum_rev 
from adobe_transactions a , cte c
where product not in ('photoshop') and a.customer_id in  ( select customer_id from Cte ) 
group by a.customer_id 

-- USING EXISTS

Select customer_id,sum(revenue) as Sum_rev 
from adobe_transactions a
where exists (
select 1 from adobe_transactions b
where product in ('photoshop') and a.customer_id=b.customer_id
) and product in ('photoshop') 
group by customer_id




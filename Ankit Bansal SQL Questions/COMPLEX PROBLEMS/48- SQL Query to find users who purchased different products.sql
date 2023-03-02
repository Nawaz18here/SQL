
 /* 48- SQL Query to find users who purchased different products
on different dates i.e products purchased on any given date are not repeated
on any other day */
------------------------------------------------------------------

--create table purchase_history
--(userid int
--,productid int
--,purchasedate date
--);
--SET DATEFORMAT dmy;
--insert into purchase_history values
--(1,1,'23-01-2012')
--,(1,2,'23-01-2012')
--,(1,3,'25-01-2012')
--,(2,1,'23-01-2012')
--,(2,2,'23-01-2012')
--,(2,2,'25-01-2012')
--,(2,4,'25-01-2012')
--,(3,4,'23-01-2012')
--,(3,1,'23-01-2012')
--,(4,1,'23-01-2012')
--,(4,2,'25-01-2012')
--;


------------------------------------------------------------------



with cte_samepdoduct as 
	(
		/* Using denserank, we can get those same products which 
		have been bought on different dates, so that we can
		filter it out later */

		select *,DENSE_RANK() over(partition by userid,productid order by productid,purchasedate) as drn
		from purchase_history
)
, cte_purchasecount as (
		/* In this cte, we are counting distinct purchase
		date so that we can filter those userid later */

		select userid,count(distinct Purchasedate) as days_cnt
		from purchase_history
		group by userid
	)
Select userid from cte_purchasecount 
where days_cnt > 1 and 
userid not in ( select userid from cte_samepdoduct where drn>1 )


------------------------------------------------------------------



WITH all_data AS(
SELECT *,DENSE_RANK()OVER(PARTITION BY userid,productid ORDER BY purchasedate ASC) AS rn
FROM purchase_history)
SELECT userid
FROM all_data
GROUP BY userid
HAVING max(rn)=1 AND count(distinct purchasedate)>1



------------------------------------------------------------------

select * from purchase_history

go 
with cte as (
	select userid,count(distinct Purchasedate) as 
	purchasedate_cnt , count(productid) as product_cnt,
	count(distinct productid) as distinct_product_cnt
	from purchase_history
	group by userid
)
select userid from cte 
where purchasedate_cnt > 1 and product_cnt = distinct_product_cnt


select userid
from purchase_history
group by userid
having count(distinct Purchasedate) > 1
and count(productid) = count(distinct productid) 

------------------------------------------------------------------



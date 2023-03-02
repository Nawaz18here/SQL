
-- 9- Leetcode Hard Problem 3 - Market Analysis 2 -2nd Fav Brand- Complex SQL 9

--create table userst (
--user_id         int     ,
-- join_date       date    ,
-- favorite_brand  varchar(50));

-- create table orderst (
-- order_id       int     ,
-- order_date     date    ,
-- item_id        int     ,
-- buyer_id       int     ,
-- seller_id      int 
-- );

-- create table items
-- (
-- item_id        int     ,
-- item_brand     varchar(50)
-- );


-- insert into userst values (1,'2019-01-01','Lenovo'),(2,'2019-02-09','Samsung'),(3,'2019-01-19','LG'),(4,'2019-05-21','HP');

-- insert into items values (1,'Samsung'),(2,'Lenovo'),(3,'LG'),(4,'HP');

-- insert into orderst values (1,'2019-08-01',4,1,2),(2,'2019-08-02',2,1,3),(3,'2019-08-03',3,2,3),(4,'2019-08-04',1,4,2)
-- ,(5,'2019-08-04',1,3,4),(6,'2019-08-05',2,2,4);


-- ------------------------------------------------------------

select * from orderst order by seller_id
select * from userst
select * from items
go

-- Using CTE and Join 

with cte_item as 
(
	select o.seller_id,o.order_date,i.item_brand,u.favorite_brand,
	DENSE_RANK()
    over(partition by o.seller_id order by o.order_date ) as DnsRnk
	from orderst o 
	left join items i on o.item_id = i.item_id
	left join userst u on o.seller_id = u.user_id
)
select od.user_id as [seller]
,IIF(ISNULL(ct.item_brand,'XXX')=ISNULL(ct.favorite_brand,'YYY'),'Yes','No') as '2nd_fav_Item'
from userst od
left join cte_item ct
on od.user_id = ct.seller_id
where DnsRnk IS NULL or DnsRnk=2

-- ------------------------------------------------------------

-- Using CTE and Join a bit easy 

go
with cte_rank as 
(
	select *, DENSE_RANK()
	over (partition by o.seller_id order by o.order_date ) as DnsRnk
	from orderst o
)
select 
	u.user_id as [seller],
	IIF( i.item_brand =u.favorite_brand,'Yes','No') as '2nd_fav_Item'
	--,o.seller_id,o.order_date,i.item_brand,u.favorite_brand,o.DnsRnk
from userst u
left join cte_rank o on o.seller_id = u.user_id and DnsRnk=2
left join items i on o.item_id = i.item_id


-- ------------------------------------------------------------

--USING UNION

select seller_id, case when item_brand = favorite_brand then 'yes' else 'no' end as fav 
FROM(
select * , row_number() over (partition by seller_id order by order_date asc) as rn from orderst
  )a
  inner join items i on a.item_id = i.item_id
  left outer join userst u on a.seller_id = u.user_id
  where rn =2
  UNION
  select u.user_id as seller_id,'no' from userst u left outer join orderst o on u.user_id = o.seller_id 
  group by u.user_id
  having count(1) <2


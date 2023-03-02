
-- 46- SQL Pre-Screening Test - Delta Records

--create table tbl_orders (
--order_id integer,
--order_date date
--);
--insert into tbl_orders
--values (1,'2022-10-21'),(2,'2022-10-22'),
--(3,'2022-10-25'),(4,'2022-10-25');

--select * into tbl_orders_copy from  tbl_orders;

--select * from tbl_orders;
--insert into tbl_orders
--values (5,'2022-10-26'),(6,'2022-10-26');
--delete from tbl_orders where order_id=1;

--------------------------------------------------------------


select * from tbl_orders
select * from tbl_orders_copy

--OUTPUT:
--Order_id, Flag
-- 1, 'D'
-- 2, 'I'
-- 3, 'I'

--------------------------------------------------------------

--USING COALESCE AND SUBQUERY 

Select * from (
	select COALESCE(t.order_id,tc.order_id) as Order_id
	,case when t.order_id is null then 'D' 
	when tc.order_id is null then 'I' 
	else 'P' end as Flag
	from tbl_orders t
	full outer join tbl_orders_copy tc
	on t.order_id = tc.order_id 
	) P
where flag<>'P'


--------------------------------------------------------------

--USING COALESCE AND WHERE CONDITION 


select COALESCE(t.order_id,tc.order_id) as Order_id
,case when t.order_id is null then 'D' 
when tc.order_id is null then 'I' end as Flag
from tbl_orders t
full outer join tbl_orders_copy tc
on t.order_id = tc.order_id 
where t.order_id is null or tc.order_id is null 
	
--------------------------------------------------------------




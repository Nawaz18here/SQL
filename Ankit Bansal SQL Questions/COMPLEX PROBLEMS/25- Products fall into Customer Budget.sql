
-- 25- Products fall into Customer Budget- Meesho HackerRank SQL Interview Question and Answer 

--create table productsC
--(
--product_id varchar(20) ,
--cost int
--);
--insert into productsC values ('P1',200),('P2',300),('P3',500),('P4',800);

--create table customer_budget
--(
--customer_id int,
--budget int
--);

--insert into customer_budget values (100,400),(200,800),(300,1500);

------------------------------------------------------------

select * from productsC
select * from customer_budget

--------------------------------------------------------------

--Use left join if none of the product is in customer budget then we should get 0 atleast

--USING CTE, JOIN AND STRING_AGG FUNC

go
with pro_cte as
	(
		select *,sum(cost) over(order by cost rows between unbounded preceding and current row) as running_total
		from productsC
	)
select
	c.customer_id,c.budget,
	count(product_id) as total_product_cnt,
	--To sort the product list, you use the WITHIN GROUP clause
	STRING_AGG(product_id,',') WITHIN GROUP (ORDER BY product_id) as list_of_product
from customer_budget c
left join pro_cte p 
on running_total<budget
group by c.customer_id,c.budget
order by c.customer_id



--------------------------------------------------------------



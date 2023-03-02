
-- 2. Complex SQL 2 | find new and repeat customers | SQL Interview Questions

--create table customer_orders (
--order_id integer,
--customer_id integer,
--order_date date,
--order_amount integer
--);
--select * from customer_orders
--insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
--,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
--,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000)
--;

---- OUTPUT: order_date,new_customer_count,repeat_customer_count

------------------------------------------------------------

-- USING CTE and LAG 

With cte as 
	(
		Select *,ISNULL(lag(customer_id) over(Partition by customer_id order by order_date ),'9999999') as Lag_Customer_Id
		from customer_orders
		--order by order_date
	)
Select order_date,
SUM(case when Lag_Customer_Id <> Customer_Id then 1 else 0 end) as new_customer_count,
SUM(case when Lag_Customer_Id = Customer_Id then 1 else 0 end) as repeat_customer_count
from cte
group by order_date
order by order_date

------------------------------------------------------------
--USING CTE 
go
with cte as 
	(
		select customer_id,min(order_date) first_order_date from customer_orders group by customer_id
	)
Select order_date,
SUM(case when c.first_order_date=o.order_date then 1 else 0 end ) as first_cust_count, 
SUM(case when c.first_order_date!=o.order_date then 1 else 0 end ) as repeat_cust_count from 
customer_orders o inner join cte c
on c.customer_id=o.customer_id
group by order_date

------------------------------------------------------------

-- USING MIN with WINDOW FUNCTION

Select a.order_date,
Sum(Case when a.order_date = a.first_order_date then 1 else 0 end) as new_customer,
Sum(Case when a.order_date != a.first_order_date then 1 else 0 end) as repeat_customer
from(
Select customer_id, order_date, min(order_date) over(partition by customer_id) as first_order_date from customer_orders) a 
group by a.order_date;


------------------------------------------------------------
--USING CTE with DenseRank
go
with cte as (
Select *,DENSE_RANK() Over(Partition by customer_id order by order_date) DnsRnk from customer_orders
)
select order_date,
SUM(case when DnsRnk= 1 then 1 else 0 end ) as first_time_cust_count,
SUM(case when DnsRnk<> 1 then 1 else 0 end ) as Repeat_time_cust_count
from cte
group by order_date

------------------------------------------------------------

-- UISNG WINDOW FUNCTION and giving it New or Repeat Customer

WITH CTE AS(
select *,CASE WHEN(DENSE_RANK()OVER(PARTITION BY customer_id ORDER BY order_date)=1) THEN 'New' 
ELSE 'Repeat' END AS IND_CUSTOMER  
from customer_orders 
)
SELECT order_date,count(CASE WHEN IND_CUSTOMER='New' THEN order_id END) AS no_new_customer,
count(CASE WHEN IND_CUSTOMER='Repeat' THEN order_id END) AS no_repeat_customer
FROM CTE
GROUP BY order_date
ORDER BY order_date


------------------------------------------------------------

-- SHOW SUM OF ORDER AMOUNT BY NEW CUSTOMER AND REPEAT CUSTOMER
--USING CTE 


with first_visit as (
select customer_id, min(order_date) as first_visit from customer_orders group by customer_id
)
select co.order_date, 
sum(case when co.order_date = fv.first_visit then order_amount end) as new_customer_amount,
sum(case when co.order_date != fv.first_visit then order_amount end) as repeated_customer_amount,
sum(case when co.order_date = fv.first_visit then 1 else 0 end) as new_customer_count,
sum(case when co.order_date != fv.first_visit then 1 else 0 end) as repeated_customer_count
from customer_orders co inner join first_visit fv on co.customer_id = fv.customer_id 
group by co.order_date order by co.order_date;

------------------------------------------------------------

-- SHOW SUM OF ORDER AMOUNT BY NEW CUSTOMER AND REPEAT CUSTOMER

-- USING MIN with WINDOW FUNCTION

Select a.order_date,
Sum(Case when a.order_date = a.first_order_date then 1 else 0 end) as new_customer,
Sum(Case when a.order_date != a.first_order_date then 1 else 0 end) as repeat_customer,
Sum(Case when a.order_date = a.first_order_date then order_amount else 0 end) as new_customer_order_amount,
Sum(Case when a.order_date != a.first_order_date then order_amount else 0 end) as repeat_customer_order_amount
from(
Select customer_id,order_amount, order_date, min(order_date) over(partition by customer_id) as first_order_date from customer_orders
) a 
group by a.order_date;

------------------------------------------------------------
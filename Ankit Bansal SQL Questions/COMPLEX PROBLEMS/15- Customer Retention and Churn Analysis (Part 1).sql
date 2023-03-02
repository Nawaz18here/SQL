
-- 15- Customer Retention and Churn Analysis (Part 1) 

/*
Customer retention refers to the ability of a company or product to retain its customers
over some specified period.

High customer retention means customers of the product or business tend to return to,
continue to buy or in some other way not defect to another product or business, or to non-use entirely. 
Company programs to retain customers: Zomato Pro , Cashbacks, Reward Programs etc.
Once these programs in place we need to build metrics to check if programs are working or not.
That is where we will write SQL to drive customer retention count.  
*/

------------------------------------------------------------

--create table transactionsT(
--order_id int,
--cust_id int,
--order_date date,
--amount int
--);
--delete from transactionsT;
--insert into transactionsT values 
--(1,1,'2020-01-15',150)
--,(2,1,'2020-02-10',150)
--,(3,2,'2020-01-16',150)
--,(4,2,'2020-02-25',150)
--,(5,3,'2020-01-10',150)
--,(6,3,'2020-02-20',150)
--,(7,4,'2020-01-20',150)
--,(8,5,'2020-02-20',150)
--;

------------------------------------------------------------

Select * from transactionsT

------------------------------------------------------------


-- USING CTE AND DENSE_RANK()

go
with cte_retention as 
	(
		Select *
		,dense_rank() over(partition by cust_id order by order_date) as drn
		from transactionsT
	)
Select Datename(month,order_date) as Order_month
,sum(case when drn= 1 then 0 else 1 end ) as Count_of_Retention
from cte_retention c
group by Datename(month,order_date)
order by Order_month desc

------------------------------------------------------------

-- USING CTE AND LAG()

go
with cte_retention as 
	(
		Select *,
		lag(order_date) over(partition by cust_id order by order_date) as prev_order
		from transactionsT
	)
Select 
Datename(month,order_date) as Order_month
,sum(case when prev_order is not null then 1 else 0 end ) as Count_of_Retention
from cte_retention c
group by Datename(month,order_date)
order by Order_month desc

------------------------------------------------------------

--USING SELF JOIN 

Select Datename(month,TM.order_date) as Order_month
, count(distinct LM.cust_id) as Count_of_Retention
from transactionsT TM
left join transactionsT LM
on TM.cust_id = LM.cust_id 
and datediff(month,LM.order_date,TM.order_date ) = 1
group by Datename(month,TM.order_date)

------------------------------------------------------------




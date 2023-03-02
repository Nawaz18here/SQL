
-- 16- Customer Retention and Churn Analysis (Part 2) 

------------------------------------------------------------

Select * from transactionsT

------------------------------------------------------------

--USING LEAD AND SUM FUNCTION

go
with cte_retention as 
	(
		Select *,
		lead(order_date) over(partition by cust_id order by order_date) as next_order
		from transactionsT
	)
Select 
Datename(month,order_date) as Order_month
,sum(case when next_order is null then 1 else 0 end ) as Count_of_Retention
from cte_retention c
group by Datename(month,order_date)
order by Order_month desc

------------------------------------------------------------

--USING SELF JOIN 

Select Datename(month,last_month.order_date) as Order_month,
count(distinct last_month.cust_id) as Count_of_Retention
from transactionsT last_month
left join transactionsT this_month
on this_month.cust_id=last_month.cust_id 
and datediff(month,last_month.order_date,this_month.order_date)=1
where this_month.cust_id is null
group by Datename(month,last_month.order_date)

------------------------------------------------------------

-- SEE DIFFERENCE BETWEEN TWO JOIN CONDITION

Select  this_month.*,last_month.*
from transactionsT last_month
left join transactionsT this_month
on this_month.cust_id=last_month.cust_id 
and datediff(month,last_month.order_date,this_month.order_date)=1


Select this_month.*,last_month.*
from transactionsT this_month 
left join transactionsT last_month
on this_month.cust_id=last_month.cust_id 
and datediff(month,last_month.order_date,this_month.order_date)=1


------------------------------------------------------------



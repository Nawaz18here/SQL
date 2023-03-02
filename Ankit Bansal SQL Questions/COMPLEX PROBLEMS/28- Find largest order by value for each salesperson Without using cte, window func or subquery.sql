
-- 28- Find largest order by value for each salesperson Without using cte, window func or subquery 

--CREATE TABLE [dbo].[int_ordersT](
-- [order_number] [int] NOT NULL,
-- [order_date] [date] NOT NULL,
-- [cust_id] [int] NOT NULL,
-- [salesperson_id] [int] NOT NULL,
-- [amount] [float] NOT NULL
--) ON [PRIMARY];

--INSERT INTO [dbo].[int_ordersT] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (30, CAST('1995-07-14' AS Date), 9, 1, 460);

--INSERT into [dbo].[int_ordersT] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (10, CAST('1996-08-02' AS Date), 4, 2, 540);

--INSERT INTO [dbo].[int_ordersT] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (40, CAST('1998-01-29' AS Date), 7, 2, 2400);

--INSERT INTO [dbo].[int_ordersT] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (50, CAST('1998-02-03' AS Date), 6, 7, 600);

--INSERT into [dbo].[int_ordersT] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (60, CAST('1998-03-02' AS Date), 6, 7, 720);

--INSERT into [dbo].[int_ordersT] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (70, CAST('1998-05-06' AS Date), 9, 7, 150);

--INSERT into [dbo].[int_ordersT] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (20, CAST('1999-01-30' AS Date), 4, 8, 1800);

------------------------------------------------------------


select * from int_ordersT

------------------------------------------------------------

--Without using cte, window func or subquery 

select a.order_number,a.order_date,a.cust_id,a.salesperson_id,a.amount
from int_ordersT a
left join int_ordersT b
on a.salesperson_id = b.salesperson_id
group by a.order_number,a.order_date,a.cust_id,a.salesperson_id,a.amount
having a.amount>= max(b.amount)


------------------------------------------------------------

--USING INNER JOIN

Select a.* from int_ordersT a inner join 
(
	select salesperson_id,max(amount) as Max_sales from int_ordersT
	group by salesperson_id
) b
on a.salesperson_id = b.salesperson_id and a.amount=b.Max_sales

------------------------------------------------------------

--USING CTE & Dense_rank()
go
with cte as
(
	select * , DENSE_RANK() over(partition by salesperson_id order by amount desc ) as drn 
	from int_ordersT
)
select * from cte c where c.drn = 1 order by cust_id

------------------------------------------------------------

--USING CTE & First_Value()

go
with cte as
(
	select * , FIRST_VALUE(amount) 
	over(partition by salesperson_id order by amount desc ) 
	as highest_amt 
	from int_ordersT
)
select * from cte c where c.amount = c.highest_amt
order by cust_id


------------------------------------------------------------


--USING ONLY LEFT JOIN

select * from int_ordersT

select * from int_ordersT


select o1.*,o2.*
from int_ordersT o1
left  join int_ordersT o2
on o1.amount<o2.amount and o1.salesperson_id=o2.salesperson_id
--where o2.amount is null
order by 1




------------------------------------------------------------













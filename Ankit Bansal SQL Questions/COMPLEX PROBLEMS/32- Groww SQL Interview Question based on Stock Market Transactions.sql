
-- 32- Groww SQL Interview Question based on Stock Market Transactions

--------------------------------------------------------------------

--Create Table Buy (
--Date Int,
--Time Int,
--Qty Int,
--per_share_price int,
--total_value int );

--Create Table sell(
--Date Int,
--Time Int,
--Qty Int,
--per_share_price int,
--total_value int );
--INSERT INTO Buy (date, time, qty, per_share_price, total_value)
--VALUES
--(15, 10, 10, 10, 100),
--(15, 14, 20, 10, 200);

--INSERT INTO Sell(date, time, qty, per_share_price, total_value)
--VALUES (15, 15, 15, 20, 300);

------------------------------------------------------------------

select * from Buy
select * from Sell

go
with cte as (
	select b.time as buy_time, b.qty as buyqty
	, s.qty as sell_qty,
	sum(b.qty) over(order by b.time ) as r_buy_qty,
	sum(b.qty) over(order by b.time rows between
	unbounded preceding and 1 preceding) as r_buy_qty_prev
	from Buy b
	inner join Sell s
	on b.date = s.date and s.time > b.time
)
	select buy_time,
	case when sell_qty>=buyqty then buyqty
	else sell_qty - r_buy_qty_prev end as buyqty,
	case when sell_qty>=buyqty then buyqty
	else sell_qty - r_buy_qty_prev end as sell_qty 
	from cte 

	 union all

	select buy_time,
	r_buy_qty - sell_qty as buy_qty,
	null as sell_qty
	from cte 
	where sell_qty<buyqty
--------------------------------------------------------------------







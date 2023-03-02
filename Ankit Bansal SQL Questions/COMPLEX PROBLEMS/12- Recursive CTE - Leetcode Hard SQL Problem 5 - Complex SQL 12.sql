
--12- Recursive CTE - Leetcode Hard SQL Problem 5 - Complex SQL 12

--create and insert script for this problem. Do try yourself without using CTE.

--create table salest (
--product_id int,
--period_start date,
--period_end date,
--average_daily_sales int
--);

--insert into salest values(1,'2019-01-25','2019-02-28',100),(2,'2018-12-01','2020-01-01',10),(3,'2019-12-01','2020-01-31',1);


--Recursive CTE Example
/*
with cte as 
(
	Select 1 as num

	union all

	select num+1 
	from cte 
	where num<10
)
select * from cte
*/
------------------------------------------------------------

select * from salest
------------------------------------------------------------

--USING RECURSIVE CTE - USE option(maxrecursion 1000) for Recursion

go
with rec_cte as 
(
	select min(period_start) as dates, max(period_end) as Max_date from salest
	union all
	Select dateadd(day,1,dates) as Start_Period, Max_date
	from rec_cte
	where dates<= Max_date
)
select s.product_id,Year(r.dates) as Report_Year, sum(s.average_daily_sales) as total_sales from rec_cte r
inner join salest s
on r.dates between s.period_start and s.period_end
group by s.product_id,Year(r.dates)
order by s.product_id
option(maxrecursion 1000)

------------------------------------------------------------

--AVOID JOIN HERE IN THIS RECURSIVE CTE

go
with rec_cte as 
(
	select product_id,period_start, period_end ,average_daily_sales from salest
	union all
	Select product_id,dateadd(day,1,period_start) ,period_end,average_daily_sales
	from rec_cte
	where period_start<= period_end
)
select --* from rec_cte order by product_id option(maxrecursion 1000) 
r.product_id,Year(r.period_start) as Report_Year, sum(r.average_daily_sales) as total_sales from rec_cte r
group by r.product_id,Year(r.period_start)
order by r.product_id
option(maxrecursion 1000)


------------------------------------------------------------




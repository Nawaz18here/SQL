
-- 5- How we can find out top 20 % products which gives 80% of the sales

--select 0.8* sum(sales) as 
--'80percent_sales_total'
--from SuperstoreData 

-- 1933386.57842374
------------------------------------------------------------

--select * from SuperstoreData


with cte as 
	(
		select product_name,
		sum(sales) as sales_total 
		from SuperstoreData 
		group by product_name 
	),
cal_sales as 
	(
		Select *,
		sum(sales_total)
		over(order by sales_total desc rows between unbounded preceding and current row) as Running_sales,
		0.8* sum(sales_total) over() as '80Percent_Sales'
		from cte
	)
select * from cal_sales c
where c.running_sales <=c.[80Percent_sales]


--select 417*1.0/1849 ( 417 rows close t0 20% of total products )


------------------------------------------------------------
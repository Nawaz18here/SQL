--21. SQL to derive Start_Date and End_Date column when there is continuous amount in Balance column

--Create Table BalanceTbl(
--Balance int,
--Dates Date
--)

--Insert into BalanceTbl Values(26000,'2020-01-01')
--Insert into BalanceTbl Values(26000,'2020-01-02')
--Insert into BalanceTbl Values(26000,'2020-01-03')
--Insert into BalanceTbl Values(30000,'2020-01-04')
--Insert into BalanceTbl Values(30000,'2020-01-05')
--Insert into BalanceTbl Values(26000,'2020-01-06')
--Insert into BalanceTbl Values(26000,'2020-01-07')
--Insert into BalanceTbl Values(32000,'2020-01-08')
--Insert into BalanceTbl Values(31000,'2020-01-09')

select * from BalanceTbl
go

With CTE as (
	select *,rnk1-rnk2 as diff from
		(
		select *, DENSE_RANK() Over( order by dates ) as Rnk1,DENSE_RANK() Over( partition by balance order by dates ) as Rnk2
		from BalanceTbl
		) A
)
--select * from CTE
Select Balance, min(dates) as Mindates, Max(dates) as Maxdates
from CTE 
group by balance,diff
order by Mindates


-- DROP TABLE BalanceTbl
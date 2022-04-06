--37. Problem Statement :- SalesInfo Table has three columns namely Continents, Country and Sales.
--Write a SQL query to get the aggregate sum  of sales  country wise and display only those which
--are maximum in each continents as shown in the table.


With CTE as (
Select *,SUM(Sales) over(Partition by Country) as TotalSales
from SalesInfo
), CTE2 as (
Select *,DENSE_RANK() Over (Partition by Continents order by TotalSales DESC ) as rnk
from CTE )

Select DISTINCT Continents,Country, TotalSales from CTE2 where rnk=1

--DROP TABLE SalesInfo
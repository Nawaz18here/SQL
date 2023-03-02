

-- 39- Populate category value to the last not null value

--create table brands 
--(
--category varchar(20),
--brand_name varchar(20)
--);
--insert into brands values
--('chocolates','5-star')
--,(null,'dairy milk')
--,(null,'perk')
--,(null,'eclair')
--,('Biscuits','britannia')
--,(null,'good day')
--,(null,'boost');


select * from brands


------------------------------------------------------------

with cte as (
select * , row_number() over(order by (select null)) as rn from brands
)
,cte2 as (
select *,sum(case when category is not null then 1 else 0 end ) over(order by rn ) as flg
from cte
)
select max(category) over(partition by flg) as cat,brand_name
from cte2

------------------------------------------------------------

with cte as(select *,
ROW_NUMBER() over(order by (select 1)) as id
from brands),
cte2 AS (select *,
sum(case when category is NULL then 0 else 1 end) over(order by id) as part
from cte)
SELECT *
,FIRST_VALUE(category) over(partition by part order by id) as fill_NA
from cte2

------------------------------------------------------------

go
with CTE as
(
	select *,ROW_NUMBER() OVER(order by (select NULL)) as rn
	from brands
), cte2 as 
(
	select category,COUNT(category) OVER(order by rn) as cnt,brand_name,rn from cte
)
select first_value(cte2.category) over(partition by cte2.cnt order by cte2.rn) as category,cte2.brand_name
from cte2


------------------------------------------------------------





WITH cte1 AS(
SELECT *, 
SUM(CASE WHEN category IS NOT NULL THEN 1 ELSE 0 END) OVER(order by (select null )
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS temp FROM brands
)
,cte2 AS(
SELECT category, temp FROM cte1
WHERE category IS NOT NULL
)

SELECT c2.category, c1.brand_name FROM cte1 c1 JOIN cte2 c2
ON c1.temp = c2.temp



------------------------------------------------------------









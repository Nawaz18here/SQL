
-- 35- Count of New Cities in Udaan

--create table business_city (
--business_date date,
--city_id int
--);
--delete from business_city;
--insert into business_city
--values(cast('2020-01-02' as date),3),(cast('2020-07-01' as date),7),(cast('2021-01-01' as date),3),(cast('2021-02-03' as date),19)
--,(cast('2022-12-01' as date),3),(cast('2022-12-15' as date),3),
--(cast('2022-02-28' as date),12);

select * from business_city

------------------------------------------------------------

-- USING CTE and RENSE RANK
go
with cte as 
	( 
		select business_date,city_id,
		Dense_Rank()over(partition by city_id order by business_date )as Rn
		from business_city
	) 
select Year(business_date) as Business_yr,count(distinct city_id) as Cnt 
from cte c
where c.rn=1
group by Year(business_date)



------------------------------------------------------------

-- USING ONLY GROUPING
go
WITH cte1 AS(
SELECT MIN(YEAR(business_date)) as "year", city_id FROM business_city
GROUP BY city_id
)

SELECT year, COUNT(city_id) AS no_of_city FROM cte1
GROUP BY year;



------------------------------------------------------------



-- USING lEFT JOIN 
go 
with cte as(
select datepart(Year,business_date) as Buss_yr, city_id from business_city )
select c1.buss_yr as Business_year, count( distinct case when c2.city_id is null then c1.city_id  end ) as #cnt_city
from cte c1
left join cte c2 on c1.Buss_yr > c2.Buss_yr and c1.city_id = c2.city_id
group by c1.Buss_yr


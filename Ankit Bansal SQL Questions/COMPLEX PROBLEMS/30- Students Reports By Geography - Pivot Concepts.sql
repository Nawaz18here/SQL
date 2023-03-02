

-- 9- Students Reports By Geography - Pivot Concepts


--create table players_location
--(
--name varchar(20),
--city varchar(20)
--);
--delete from players_location;
--insert into players_location
--values ('Sachin','Mumbai'),('Virat','Delhi') , ('Rahul','Bangalore'),('Rohit','Mumbai'),('Mayank','Bangalore');



select * from players_location

------------------------------------------------------------

-- Visulaziting how it will look then we will use group by Groups

select Groups,
case when city='Bangalore' then name else null end  as  'Bangalore' ,
case when city='Delhi' then name else null end as 'Delhi',
case when city='Mumbai' then name else null end as 'Mumbai'
from (
select *,Row_number() over(partition by city order by name ) as Groups from players_location
) a
order by groups


------------------------------------------------------------

-- USING GROUP and using MAX in CASE WHEN Statement

select 
MAX(case when city='Bangalore' then name else null end ) as  'Bangalore' ,
MAX(case when city='Mumbai' then name else null end )as 'Mumbai',
MAX(case when city='Delhi' then name else null end )as 'Delhi'
from (
select *,Row_number() over(partition by city order by name ) as Groups from players_location
) a
group by groups


------------------------------------------------------------
-- USING GROUP and using MAX Later


with cte as(
select city,
case when city='Bangalore' then name end as 'Bangalore',
case when city='Mumbai' then name end as 'Mumbai',
case when city='Delhi' then name end as 'Delhi',
row_number() over(partition by city order by name asc) as rn
 from players_location
)
select max(Bangalore) Bangalore,max(Mumbai) Mumbai, max(Delhi) Delhi from cte group by rn

----------------------REVISION--------------------------------------

select * from players_location

--USING PIVOT TABLE

Select Bangalore,Mumbai,Delhi
from 
	(
		select *,row_number() over(partition by city order by name) as row_num 
		from players_location
	) sourcetbl
PIVOT
	(
		 max(name)
		 for city in (Bangalore,Mumbai,Delhi)
	) PivotTbl

------------------------------------------------------------

--USING MAX FUNC & ROW_NUMBER()

Select 
max(case when city = 'Bangalore' then name end) as 'Bangalore',
max(case when city = 'Mumbai' then name end) as 'Mumbai',
max(case when city = 'Delhi' then name end) as 'Delhi'
from (
select *,row_number() over(partition by city order by name) as row_num 
from players_location
) a
group by row_num

------------------------------------------------------------




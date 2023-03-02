
-- 21- Find Missing Quarter

--CREATE TABLE STORES (
--Store varchar(10),
--Quarter varchar(10),
--Amount int);

--INSERT INTO STORES (Store, Quarter, Amount)
--VALUES ('S1', 'Q1', 200),
--('S1', 'Q2', 300),
--('S1', 'Q4', 400),
--('S2', 'Q1', 500),
--('S2', 'Q3', 600),
--('S2', 'Q4', 700),
--('S3', 'Q1', 800),
--('S3', 'Q2', 750),
--('S3', 'Q3', 900);

------------------------------------------------------------
select * from STORES
------------------------------------------------------------

--USING CTE AND SUM - 1ST

go
with cte as
(
select *--,right(quarter,1) as quar_no ,left(quarter,1) as quarter_name
,10 - sum( CAST(right(quarter,1) as int )) over(partition by store ) as rem_quarter
from STORES
)
select store,CONCAT(MAX(left(quarter,1)), MAX(rem_quarter)) as missing_quarter
from cte
group by store


------------------------------------------------------------

--ONE LINER 

go
select store
, 'Q' + cast (10 - sum( CAST(right(quarter,1) as int )) as nvarchar(4) )as rem_quarter
from stores
group by store

------------------------------------------------------------

--USING CTE AND SUM - 2ND
go
WITH CTE AS(
SELECT *,(CAST(SUBSTRING(Quarter,2,1) As Int)) AS Existing_Quarter
FROM STORES
)
SELECT Store,CONCAT('Q',(10-SUM(Existing_Quarter))) AS missing_Quarter
FROM CTE
GROUP BY Store

------------------------------------------------------------

--USING RECURSIVE CTE

go
with rec_cte as
(
	select distinct store,1 as quarter_no from stores
	union all
	select store,quarter_no+1 from rec_cte
	where quarter_no<4
)
, quarter_cte as
(
	select store, 'Q' + cast ( quarter_no as nvarchar(4) ) as quarter_no
	from rec_cte
)
select q.* from quarter_cte q
left join stores s 
on q.store = s.store and q.quarter_no = s.Quarter
where s.Quarter is null


------------------------------------------------------------

--USING CROSS

go
with allquarter_cte as
(
	select distinct s1.store,s2.quarter
	from stores s1, stores s2
)

select q.* from allquarter_cte q
left join stores s 
on q.store = s.store and q.quarter = s.Quarter
where s.Quarter is null


------------------------------------------------------------


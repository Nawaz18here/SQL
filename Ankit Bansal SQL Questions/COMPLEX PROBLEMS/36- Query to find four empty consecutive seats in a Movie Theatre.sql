
-- 36- Query to find four empty consecutive seats in a Movie Theatre

-- PharmEasy SQL Interview Question | Consecutive Seats in a Movie Theatre | Data Analytics

--create table movie(
--seat varchar(50),occupancy int
--);
--insert into movie values('a1',1),('a2',1),('a3',0),('a4',0),('a5',0),('a6',0),('a7',1),('a8',1),('a9',0),('a10',0),
--('b1',0),('b2',0),('b3',0),('b4',1),('b5',1),('b6',1),('b7',1),('b8',0),('b9',0),('b10',0),
--('c1',0),('c2',1),('c3',0),('c4',1),('c5',1),('c6',0),('c7',1),('c8',0),('c9',0),('c10',1);


------------------------------------------------------------

select * from movie

go
with cte1 as 
(
	select seat,
	left(seat,1) as row_char,
	cast(Substring(seat,2,2) as int) as row_no, occupancy
	from movie
), cte2 as
(
	Select *,
	max(occupancy) over( partition by row_char 
	order by row_no rows between current row and 3 following
	) as first_empty_4,
	count(occupancy) over( partition by row_char 
	order by row_no rows between current row and 3 following
	) as count_empty_4
	from cte1
), cte3 as 
(
	Select * from cte2
	where first_empty_4 = 0 and count_empty_4 = 4
)
select c1.*
from cte1 c1
inner join cte3 c3 on c1.row_char = c3.row_char 
and c1.row_no between c3.row_no and c3.row_no+3

------------------------------------------------------------

select * from movie


--USING MULTIPLE CTEs: Nice Approach ( Short method )

with cte as
(
	select *,substring(seat,1,1) as row, cast(substring(seat,2,2) as int) as seat_no,
	row_number() over(partition by substring(seat,1,1) order by cast(substring(seat,2,2) as int)) as rn,
	(cast(substring(seat,2,2) as int) - row_number() over(partition by substring(seat,1,1) order by cast(substring(seat,2,2) as int))) as diff 
	from movie
	where occupancy=0	
)
select seat
from
(select seat,
count(diff) over(partition by row, diff) as cnt
from cte) A
where cnt=4

------------------------------------------------------------

--USING MULTIPLE CTEs: Nice Approach ( Long method for undetstanding )

with cte as
(
	select *,substring(seat,1,1) as row, cast(substring(seat,2,2) as int) as seat_no
	from movie
)
,cte2 as (
	select * , row_number() over(partition by row order by seat_no ) as rn,
	seat_no - row_number() over(partition by row order by seat_no) as diff 
	from cte
	where occupancy=0	
)
,cte3 as (
select *,
count(diff) over(partition by row, diff) as cnt
from cte2
)
select * from cte3
where cnt=4


------------------------------------------------------------


with cte as(
select seat, 
	cast(
	cast(substring(seat,2,3) as int)
	-row_number() over(partition by left(seat,1) order by cast(substring(seat,2,3) as int)) as varchar(2)) + left(seat,1) as grp 
	from movie where occupancy =0
	)
select seat from cte where grp in(
select grp from cte group by grp having count(*)>=4
)

------------------------------------------------------------


WITH SEAT AS
(
	SELECT *,substring(seat,1,1) AS seat_row_no,substring(seat,2,(len(seat))) AS seat_no
	FROM  movie
	WHERE occupancy=0
)
,CTE_GROUP AS (
	SELECT *,(seat_no-(ROW_NUMBER()OVER(PARTITION BY seat_row_no ORDER BY CAST(seat_no AS int) ASC))) AS diff
	FROM SEAT
)
,CTE_4_CONSECUTIVE AS
(
	SELECT seat,seat_row_no,diff,COUNT(*)OVER(PARTITION BY seat_row_no,diff ORDER BY seat_row_no) AS cnt
	FROM CTE_GROUP
)
SELECT * FROM CTE_4_CONSECUTIVE
WHERE cnt=4


------------------------------------------------------------



WITH CTE AS
(
SELECT *,SUBSTRING(seat,1,1) as row, cast(SUBSTRING(seat,2,2) as int) as seq FROM movie
)
, CTE1 AS(
SELECT * , seq - ROW_NUMBER() OVER(PARTITION BY row ORDER BY seq) as diff FROM CTE WHERE occupancy = 0
)
, CTE2 AS (
	SELECT *, COUNT(*) OVER(PARTITION BY diff,row ORDER BY diff) as cnt FROM CTE1 
  )
SELECT * FROM CTE2 WHERE CNT >= 4

------------------------------------------------------------









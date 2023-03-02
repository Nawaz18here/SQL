
--34-  Human Traffic of Stadium

--create table stadium (
--id int,
--visit_date date,
--no_of_people int
--);

--insert into stadium
--values (1,'2017-07-01',10)
--,(2,'2017-07-02',109)
--,(3,'2017-07-03',150)
--,(4,'2017-07-04',99)
--,(5,'2017-07-05',145)
--,(6,'2017-07-06',1455)
--,(7,'2017-07-07',199)
--,(8,'2017-07-08',188);

--------------------------------------------------------------

--USNG MULTIPLE CTEs

go
with cte as (
	select *,
	case when no_of_people>100 then 'Y' else 'N' end as Flag
	from stadium
)
, cte2 as (
	select *,ROW_NUMBER() over(order by visit_date) as rownum,
	id - ROW_NUMBER() over(order by visit_date) as diff
	from cte
	where flag='Y'
)
,cte3 as (
	select *, count(1) over(partition by diff) as cnt from cte2 
)
select * from cte3 where cnt>=3

--------------------------------------------------------------

--USING ADVANCE AGGREGATION


go
with cte as (
	select *,
	sum(case when no_of_people > 100 then 1 end ) over
	(order by visit_date rows between current row and 2 following )
	as next_2
	,sum(case when no_of_people > 100 then 1 end ) over
	(order by visit_date rows between 2 preceding and current row  )
	as prev_2
	,sum(case when no_of_people > 100 then 1 end ) over
	(order by visit_date rows between 1 preceding and 1 following  )
	as prev_next_1
	from stadium
	)
	select * from cte
	where 3 in (next_2,prev_2,prev_next_1)

--------------------------------------------------------------

--USING GROUPKEY CONCEPT ( SHORT )

go
with cte as (
	select *,ROW_NUMBER() over(order by visit_date) as rownum,
	id - ROW_NUMBER() over(order by visit_date) as grpkey
	from stadium
	where no_of_people>100
	)
select id,visit_date,no_of_people
from cte
where grpkey in 
	(
		select grpkey from cte group by grpkey having count(1) >=3
	)



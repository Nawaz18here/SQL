
 /* 41- SQL to find out callers whose first and last call 
 was to the same person on a given day */


--create table phonelog(
--    Callerid int, 
--    Recipientid int,
--    Datecalled datetime
--);

--insert into phonelog(Callerid, Recipientid, Datecalled)
--values(1, 2, '2019-01-01 09:00:00.000'),
--       (1, 3, '2019-01-01 17:00:00.000'),
--       (1, 4, '2019-01-01 23:00:00.000'),
--       (2, 5, '2019-07-05 09:00:00.000'),
--       (2, 3, '2019-07-05 17:00:00.000'),
--       (2, 3, '2019-07-05 17:20:00.000'),
--       (2, 5, '2019-07-05 23:00:00.000'),
--       (2, 3, '2019-08-01 09:00:00.000'),
--       (2, 3, '2019-08-01 17:00:00.000'),
--       (2, 5, '2019-08-01 19:30:00.000'),
--       (2, 4, '2019-08-02 09:00:00.000'),
--       (2, 5, '2019-08-02 10:00:00.000'),
--       (2, 5, '2019-08-02 10:45:00.000'),
--       (2, 4, '2019-08-02 11:00:00.000');


--------------------------------------------------------------

select * from phonelog

--------------------------------------------------------------

--USING FIRST VALUE AND LAST VALUE WINDOW FUNCTION

go
with cte as (

	select *
	,first_value(recipientid) over(partition by callerid,
	CONVERT(varchar,datecalled,23)
	order by datecalled ) as first_cal

	,last_value(recipientid) over(partition by callerid,
	CONVERT(varchar,datecalled,23)
	order by datecalled rows between unbounded preceding and 
	unbounded following ) as last_cal
	from phonelog
)
select distinct
callerid, recipientid,
CONVERT(varchar,datecalled,23) as called_date
from cte 
where (recipientid = first_cal) and (recipientid =  last_cal)



--------------------------------------------------------------

select * from phonelog

go
with cte as (
	select callerid,min(datecalled) as first_cal_time
	,max(datecalled) as last_cal_time
	from phonelog
	group by callerid,cast(datecalled as date)
	)
select c.*,p1.recipientid as first_cal_rec
--,p2.recipientid as last_cal_rec
from cte c
inner join phonelog p1 on p1.callerid = c.callerid
and c.first_cal_time = p1.datecalled
inner join phonelog p2 on p2.callerid = c.callerid
and c.last_cal_time = p2.datecalled
where p1.recipientid = p2.recipientid 

--------------------------------------------------------------


with cte as (select *,
cast(Datecalled as date) as dated
from phonelog),
cte2 as (select *,
case when first_value(Recipientid) over(partition by Callerid,dated order by Datecalled) =
first_value(Recipientid) over(partition by Callerid,dated order by Datecalled desc) then 0 else 1 end as flg
from cte)
select Callerid,dated,*
from cte2
group by Callerid,dated
having max(flg)=0

--------------------------------------------------------------

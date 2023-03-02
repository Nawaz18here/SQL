

-- 37- Duration of outgoing call greater than incoming call

--create table call_details  (
--call_type varchar(10),
--call_number varchar(12),
--call_duration int
--);

--insert into call_details
--values ('OUT','181868',13),('OUT','2159010',8)
--,('OUT','2159010',178),('SMS','4153810',1),('OUT','2159010',152),('OUT','9140152',18),('SMS','4162672',1)
--,('SMS','9168204',1),('OUT','9168204',576),('INC','2159010',5),('INC','2159010',4),('SMS','2159010',1)
--,('SMS','4535614',1),('OUT','181868',20),('INC','181868',54),('INC','218748',20),('INC','2159010',9)
--,('INC','197432',66),('SMS','2159010',1),('SMS','4535614',1);


--------------------------------------------------------------


select * from call_details
order by call_number, call_type

--------------------------------------------------------------

--USING CTE and FILTER ( CASE WHEN WITH SUM AND WHERE CONDITION )

go 
with cte as (
	select call_number,
	Sum(case when call_type = 'Inc' then call_duration end )
	as call_in_time,
	Sum(case when call_type = 'Out' then call_duration end ) 
	as call_out_time
	from call_details
	where call_type in ('Inc','Out')
	group by call_number
	--order by call_number
)
select * from cte c
where --c.call_out_time is not null and c.call_in_time is not null and 
c.call_out_time > c.call_in_time


--------------------------------------------------------------

--USING HAVING CLAUSE

select call_number
from call_details
group by call_number
having
Sum(case when call_type = 'Inc' then call_duration end )
> 0 and
Sum(case when call_type = 'Out' then call_duration end ) 
> 0 and
Sum(case when call_type = 'Out' then call_duration end ) 
> Sum(case when call_type = 'Inc' then call_duration end )

--------------------------------------------------------------

--USING CTE AND JOIN

go 
with cte_out as (
	select call_number,
	Sum(call_duration ) as call_duration
	from call_details
	where call_type in ('Out')
	group by call_number
)
,cte_in as (
select call_number,
	Sum(call_duration ) as call_duration
	from call_details
	where call_type in ('Inc')
	group by call_number

)
select co.call_number from cte_out co
inner join cte_in ci on co.call_number = ci.call_number
where co.call_duration > ci.call_duration

--------------------------------------------------------------

--USING CTE WITH LAG


with cte as (
	select call_number,call_type,
	sum(call_duration) AS OUT
	,lag(sum(call_duration),1) over(partition by call_number order by call_type) as INC
	from call_details
	where call_type in ('INC','OUT')
	group by call_number,call_type
)
select call_number,OUT,INC from cte where OUT>INC


--------------------------------------------------------------

--USING CTE WITH RANK


with cte1 as (
select call_number,call_type , sum(call_duration) as duration
,rank() over ( partition by call_number order by call_type) as rnk
from call_details 
where call_type <> 'SMS' group by call_number,call_type
)

, cte2 as (Select * ,
lead(duration,1,0) over ( partition by call_number order by call_type ) as out_duration from cte1 )

Select * from cte2 where out_duration > duration;


--------------------------------------------------------------


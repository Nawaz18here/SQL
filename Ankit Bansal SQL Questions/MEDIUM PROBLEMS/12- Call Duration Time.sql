
-- 12- Call Duration Time

--create table call_start_logs
--(
--phone_number varchar(10),
--start_time datetime
--);
--insert into call_start_logs values
--('PN1','2022-01-01 10:20:00'),('PN1','2022-01-01 16:25:00'),('PN2','2022-01-01 12:30:00')
--,('PN3','2022-01-02 10:00:00'),('PN3','2022-01-02 12:30:00'),('PN3','2022-01-03 09:20:00')
--create table call_end_logs
--(
--phone_number varchar(10),
--end_time datetime
--);
--insert into call_end_logs values
--('PN1','2022-01-01 10:45:00'),('PN1','2022-01-01 17:05:00'),('PN2','2022-01-01 12:55:00')
--,('PN3','2022-01-02 10:20:00'),('PN3','2022-01-02 12:50:00'),('PN3','2022-01-03 09:40:00')
--;

 
--------------------------------------------------------------

--USING CTE,RANK AND DATEDIFF

with cte_s as 
(
	Select * ,
	rank() Over(partition by phone_number order by start_time)
	as rn_s
	from call_start_logs
) , 
cte_e as 
(
	Select * ,
	rank() Over(partition by phone_number order by end_time)
	as rn_e
	from  call_end_logs
)
select s.phone_number,s.start_time,
e.end_time,datediff(MINUTE,s.start_time,e.end_time)
as duration_sec from 
cte_s s, cte_e e
where s.rn_s = e.rn_e and s.phone_number=e.phone_number


--Select * from call_start_logs s
--inner join call_end_logs e
--on s.start_time > e.end_time 
--and s.phone_number=e.phone_number

--------------------------------------------------------------

--USING UNION

Select phone_number, min(call_time) as start_time,
max(call_time) as end_time, datediff(minute, min(call_time),max(call_time)) as call_dur from 
(
	Select phone_number, start_time as call_time,
	row_number() Over(partition by phone_number order by start_time)
	as rn_s
	from call_start_logs
union all 
	Select * ,
	row_number() Over(partition by phone_number order by end_time)
	as rn_e
	from  call_end_logs
) A 
group by phone_number,rn_s



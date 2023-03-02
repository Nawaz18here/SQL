

-- 14- Amazon Prime Subscription Rate SQL Logic - Amazon Music - Complex SQL 14

--create table usersQ
--(
--user_id integer,
--name varchar(20),
--join_date date
--);
--insert into usersQ
--values (1, 'Jon', CAST('2-14-20' AS date)), 
--(2, 'Jane', CAST('2-14-20' AS date)), 
--(3, 'Jill', CAST('2-15-20' AS date)), 
--(4, 'Josh', CAST('2-15-20' AS date)), 
--(5, 'Jean', CAST('2-16-20' AS date)), 
--(6, 'Justin', CAST('2-17-20' AS date)),
--(7, 'Jeremy', CAST('2-18-20' AS date));

--create table eventsT
--(
--user_id integer,
--type varchar(10),
--access_date date
--);

--insert into eventsT values
--(1, 'Pay', CAST('3-1-20' AS date)), 
--(2, 'Music', CAST('3-2-20' AS date)), 
--(2, 'P', CAST('3-12-20' AS date)),
--(3, 'Music', CAST('3-15-20' AS date)), 
--(4, 'Music', CAST('3-15-20' AS date)), 
--(1, 'P', CAST('3-16-20' AS date)), 
--(3, 'P', CAST('3-22-20' AS date));


--------------------------------------------------------------
select * from usersQ u
select * from eventsT e

--------------------------------------------------------------

--USING MULTIPLE CTEs


go
with cte as (
	select u.user_id,u.join_date,e.type,e.access_date
	,datediff(day,u.join_date , e.access_date ) as day_diff
	,lag(type) over(partition by u.user_id order by type ) as prev_type
	from usersQ u
	inner join eventsT e
	on u.user_id = e.user_id
	where e.type <> 'Pay'
)
,cte_music_cnt as (
	select count(1) as total_music_user from eventsT
	where type = 'Music'
)
,cte_purchased_cnt as (
	Select count(1) as purchased_user from cte
	where type='P' and [prev_type] = 'Music' and day_diff <30
)
select purchased_user * 1.0 / total_music_user * 100 as  fraction_usr
from cte_music_cnt,cte_purchased_cnt

--------------------------------------------------------------

--USING ONLY ONE MAIN QUERY

select --u.*,ev.type,ev.access_date,datediff(day,join_date,access_date ) as da_diff
count(distinct u.user_id) as total_user , count(case when datediff(day,join_date,access_date ) > 30 then 1 end ) as prime_user 
,1.0* count(case when datediff(day,join_date,access_date ) > 30 then 1 end ) / count(distinct u.user_id) *100 as fraction_user
from usersQ u
left join eventsT ev on u.user_id = ev.user_id and type = 'P'
where u.user_id in ( select user_id from eventsT e where e.type = 'music' )


--------------------------------------------------------------
-- 7- Data Analyst Take Home Assignment by A Startup  - Spotify Case Study 

--CREATE table activity
--(
--user_id varchar(20),
--event_name varchar(20),
--event_date date,
--country varchar(20)
--);
--delete from activity;
--insert into activity values (1,'app-installed','2022-01-01','India')
--,(1,'app-purchase','2022-01-02','India')
--,(2,'app-installed','2022-01-01','USA')
--,(3,'app-installed','2022-01-01','USA')
--,(3,'app-purchase','2022-01-03','USA')
--,(4,'app-installed','2022-01-03','India')
--,(4,'app-purchase','2022-01-03','India')
--,(5,'app-installed','2022-01-03','SL')
--,(5,'app-purchase','2022-01-03','SL')
--,(6,'app-installed','2022-01-04','Pakistan')
--,(6,'app-purchase','2022-01-04','Pakistan');

------------------------------------------------------------

Select * from activity

------------------------------------------------------------

-- 1- Find total active users each day

select event_date, count(distinct user_id ) as tot_active_users
from activity group by event_date

------------------------------------------------------------

-- 2- Find total active users each week 

Select 
	datepart(WEEK,event_date) as Week_num , 
	count(distinct user_id ) as active_users_week
from activity
group by  Week_num

------------------------------------------------------------

-- Date-wise total users who made the purchase same day they
-- installed the app


with cte as 
	(
		Select *,
		lead(event_date) over ( partition by user_id order by 
		event_name ) as Lead_ev_date
		from activity
	),
cte2 as (
select * from cte c
--where datediff(day,c.Lead_ev_date,event_date ) = 0 
) 
Select user_id,max(event_date),max(Lead_ev_date) --event_date, count(*)  as Cnt_users
from cte2
group by user_id,event_date
order by user_id


------------------------------------------------------------

-- USING CTE 

With cte as 
(
	Select
		user_id,
		max(case when event_name = 'app-installed' then event_date 
		end )as install_date,
		max(case when event_name ='app-purchase' then event_date
		end )as purchase_date
	from activity
	group by user_id
), 
cte2 as 
	(
	Select *,
		case when datediff(day,c.install_date,purchase_date ) = 0
		then 1 else null end as flag
	from cte c
	), 
cte3 as 
	(
	select 
		case when purchase_date is null then install_date
		else purchase_date end as event_date , flag from cte2
	)
select event_date, count(flag) as no_users_same_day_pur
from cte3
group by event_date



--USING SUBQUERY

Select event_date, count(new_users) as No_of_users from (
	Select user_id,event_date,
	case when count(distinct event_name ) =2 then user_id 
	else null end as new_users
	from activity 
	group by user_id,event_date
	--Having count(distinct event_name )  = 2
) a 
group by event_date



-- USING JOIN 

select a.event_date,
sum(case when a.event_name <> b.event_name 
and a.event_name='app-installed' then 1 else 0 end) as case_total  
from activity a inner join activity b
on a.user_id=b.user_id
and a.event_date=b.event_date
group by a.event_date;

------------------------------------------------------------

-- 4. Country wise paid user percentage 

with cte as (
Select 
	case when country in ('USA','India') then 
	country else 'others' end as new_country, 
	count(distinct user_id ) as Cnt_Usr_Country
from activity
	where event_name='app-purchase'
group by
case when country in ('USA','India') then country else 'others' end 
), cte2 as ( select sum(Cnt_Usr_Country) as total_users from cte )
select *,(Cnt_Usr_Country*1.0/total_users)*100 as percentage_users from 
cte,cte2


------------------------------------------------------------


Select * from activity

-- 5. Among all users who installed the app on a given day
-- how many did in app purchased the very next day

Select b.event_date,
sum(case when a.event_date<>b.event_date
then 0 else 1 end ) as cnr_users
	from 
	(
		select * 
		from
			(
				Select *,
				lag(event_date) over ( partition by user_id order by 
				event_name ) as Lead_ev_date
				from activity
			) x
		where
		datediff(day,Lead_ev_date,x.event_date )=1
	) a right join activity b on a.event_date<>b.event_date
group by b.event_date



--Using CTE

with cte as 
(
Select *,
lag(event_date) over ( partition by user_id order by event_name ) as prev_event_date,
lag(event_name) over ( partition by user_id order by event_name ) as prev_event_name
from activity
)
select event_date,
--, count(distinct user_id ) as cnt
count(case when prev_event_name = 'app-installed' and event_name ='app-purchase' 
and datediff(day,prev_event_date,event_date )=1 then user_id else null end ) as users_cnt
from cte
group by event_date

------------------------------------------------------------


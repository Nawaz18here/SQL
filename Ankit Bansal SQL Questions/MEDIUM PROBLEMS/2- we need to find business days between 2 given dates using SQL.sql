/*
we are going to solve a very important business use 
case where we need to find difference between 2 dates
excluding weekends and public holidays . Basically we need to find business days between 2 given dates using SQL. 
*/

--script:
--create table tickets
--(
--ticket_id varchar(10),
--create_date date,
--resolved_date date
--);
--delete from tickets;
--insert into tickets values
--(1,'2022-08-01','2022-08-03')
--,(2,'2022-08-01','2022-08-12')
--,(3,'2022-08-01','2022-08-16');

/*This Holiday Table contains only those holiday which occurs only on weekdays */ 

--create table holidays
--(
--holiday_date date
--,reason varchar(100)
--);
--delete from holidays;
--insert into holidays values
--('2022-08-11','Rakhi'),('2022-08-15','Independence day');


/*This Holiday2 Table contains those holiday which occurs both on weekdays and weekend */ 

--create table holidays2
--(
--holiday_date date
--,reason varchar(100)
--);
--insert into holidays2 values
--('2022-08-07','National'),('2022-08-11','Rakhi'),('2022-08-13','Office day'),('2022-08-15','Independence day');


--SELECT DATENAME(weekday, '2022/08/14') AS DatePartString;


Select * from tickets
select *, datename(weekday,holiday_date) from holidays2
go



/*If Holiday occurs only on weekdays only */ 


Select ticket_id,create_date,resolved_date,act_days_wo_weekend,Cnt_holiday,(act_days_wo_weekend -  Cnt_holiday) as 'Business_days'
from (
	Select ticket_id,create_date,resolved_date,COUNT(holiday_date) as Cnt_holiday,
	( DATEDIFF(DD,create_date,resolved_date)- 2 * DATEDIFF(WEEK,create_date,resolved_date)  ) as act_days_wo_weekend
	from tickets left join holidays
	on holiday_date between create_date and resolved_date
	group by ticket_id,create_date,resolved_date
)a
go

------------------------------------------------------------------

	
/*If Holiday occurs only on both weekend & weekdays */ 


with cte as
(
	select *, datepart(weekday,holiday_date) as day_name from holidays2
	where datepart(weekday,holiday_date) not in (1,7)
), cte2 as
(
	Select ticket_id,create_date,resolved_date,
	( DATEDIFF(DD,create_date,resolved_date)- 2 * DATEDIFF(WEEK,create_date,resolved_date)  ) as act_days_wo_weekend
	from tickets 
), cte3 as
(
	Select ticket_id,create_date,resolved_date,count(holiday_date) as Cnt_holiday, act_days_wo_weekend
	from cte2 c2 left join cte c1
	on c1.holiday_date between c2.create_date and c2.resolved_date
	group by ticket_id,create_date,resolved_date,act_days_wo_weekend 
)
Select *, act_days_wo_weekend- Cnt_holiday as 'Business_days'
from cte3 c3

------------------------------------------------------------------


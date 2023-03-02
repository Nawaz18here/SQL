
-- 18- Total charges as per billrate

--create table billings 
--(
--emp_name varchar(10),
--bill_date date,
--bill_rate int
--);
--delete from billings;
--insert into billings values
--('Sachin','01-JAN-1990',25)
--,('Sehwag' ,'01-JAN-1989', 15)
--,('Dhoni' ,'01-JAN-1989', 20)
--,('Sachin' ,'05-Feb-1991', 30)
--;

--create table HoursWorked 
--(
--emp_name varchar(20),
--work_date date,
--bill_hrs int
--);
--insert into HoursWorked values
--('Sachin', '01-JUL-1990' ,3)
--,('Sachin', '01-AUG-1990', 5)
--,('Sehwag','01-JUL-1990', 2)
--,('Sachin','01-JUL-1991', 4)

----------------------------------------------------------------

select * from billings
select * from HoursWorked

----------------------------------------------------------------

--select *, lead(dateadd(day,-1,bill_date),1,'9999-12-31') over(partition by emp_name 
--order by bill_date ) as next_billdate
--from billings

--select * from HoursWorked

----------------------------------------------------------------

--USING LEAD FUNCTION

go
with cte as (
	select *, lead(dateadd(day,-1,bill_date),1,'9999-12-31') over(partition by emp_name 
	order by bill_date ) as next_billdate
	from billings
	)
select c.emp_name, sum(c.bill_rate * h.bill_hrs) as totalcharges
from HoursWorked h
inner join cte c
on h.emp_name = c.emp_name and h.work_date between c.bill_date and c.next_billdate
group by c.emp_name


----------------------------------------------------------------







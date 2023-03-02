
-- 23- Identify cities where covid cases increasing everyday

--create table covid(city varchar(50),days date,cases int);
--delete from covid;
--insert into covid values('DELHI','2022-01-01',100);
--insert into covid values('DELHI','2022-01-02',200);
--insert into covid values('DELHI','2022-01-03',300);

--insert into covid values('MUMBAI','2022-01-01',100);
--insert into covid values('MUMBAI','2022-01-02',100);
--insert into covid values('MUMBAI','2022-01-03',300);

--insert into covid values('CHENNAI','2022-01-01',100);
--insert into covid values('CHENNAI','2022-01-02',200);
--insert into covid values('CHENNAI','2022-01-03',150);

--insert into covid values('BANGALORE','2022-01-01',100);
--insert into covid values('BANGALORE','2022-01-02',300);
--insert into covid values('BANGALORE','2022-01-03',200);
--insert into covid values('BANGALORE','2022-01-04',400);

------------------------------------------------------------

Select * from covid

------------------------------------------------------------
go
with cte as 
	(
		Select *,rank() over( partition by city order by days,cases)  as Rn_days,
		rank() over( partition by city  order by cases)  as Rn_case,
		rank() over( partition by city order by days,cases) - rank() over( partition by city  order by cases)  as flag
		from covid
	)
Select city
from cte 
group by city
having count(distinct flag)=1

------------------------------------------------------------


--USING LAG and SUBQUERY

go
with cte as (
Select *,cases - lag(cases) over(partition by city order by days,cases)  as diff_cases 
from covid
)
select distinct c.city
from cte c
where city not in ( select c.city from cte c where c.diff_cases<=0 )


------------------------------------------------------------

Select * from covid

--USING JOIN


select distinct city from covid where city not in 
(
select a.city
from covid a
inner join covid b on
a.city = b.city and a.days < b.days and a.cases>=b.cases ) 

------------------------------------------------------------
--USING GROUP BY and LAG


with delta_cte as(
select *,
case when (cases-lag(cases,1,0) over (partition by city order by days))>0 then 0 else 1 end as delta
from covid 
)

select city,sum(delta) as s_delta 
from delta_cte 
group by city
having sum(delta)=0

------------------------------------------------------------


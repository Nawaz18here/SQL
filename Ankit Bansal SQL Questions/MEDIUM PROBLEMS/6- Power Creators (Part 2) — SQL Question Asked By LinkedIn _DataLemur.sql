-- 6- Power Creators (Part 2) — 
-- SQL Question Asked By LinkedIn _DataLemur

--create table personal_profiles
--( profile_id int,
--name varchar(50),
--followers int
--)

--insert into personal_profiles 
--values(1,'Nick Singh',92000),
--(2,'Zack Wilson',199000),
--(3,'Daliana Liu',171000),
--(4,'Ravit Jain',107000),
--(5,'Vin Vashishta',139000),
--(6,'Susan Wojcicki',39000)

------------------------------


--create table employee_company
--( personal_profile_id int,
--company_id int
--)

--insert into employee_company 
--values(1,4),(1,9),(2,2),(3,1),(4,3),(5,6),(6,5)

------------------------------

--create table company_pages
--( company_id int,
--name varchar(50),
--followers int
--)

--insert into company_pages 
--values
--(1,'The Data Science Podcast',8000),
--(2,'Airbnb',700000),
--(3,'The Ravit Show',6000),
--(4,'Data Lemur',200),
--(5,'Youtube',16000000),
--(6,'DataScience Vin',4500),
--(9,'Ace The DataScience Interview',4479)


--DROP TABLE personal_profiles 
--DROP TABLE employee_company
--DROP TABLE company_pages


Select * from personal_profiles pp
Select * from employee_company ec
Select * from company_pages cp
go




---USING INNER JOIN AND SUBQUERY

Select pp.profile_id,
pp.name 
from personal_profiles pp
Inner join (
Select 
	ec.personal_profile_id,
	MAX(cp.followers) as Pages_Followers_Cnt
	from employee_company ec
	inner join company_pages cp
	on ec.company_id = cp.company_id
	group by ec.personal_profile_id
	) a
on pp.profile_id=a.personal_profile_id
where pp.followers>a.Pages_Followers_Cnt

------------------------------------------------------------------

--USING CTE AND HAVING

with cte 
as 
(
	Select pp.[name],
	pp.profile_id,pp.followers 'profile_followers',
	ec.personal_profile_id,cp.[name] 'company_name',
	cp.followers 'company_followers', cp.company_id
	from personal_profiles pp
	inner join employee_company ec
	on pp.profile_id = ec.personal_profile_id
	inner join company_pages cp
	on ec.company_id = cp.company_id 
) 

Select profile_id,profile_followers
from CTE c
Group by profile_id,profile_followers
having max(c.company_followers)<profile_followers


------------------------------------------------------------------

-- USING CTE AND CASE STATEMENT 

with cte as (
	Select 
		pp.[name],pp.profile_id,pp.followers 'profile_followers',
		ec.personal_profile_id,cp.[name] 'company_name',
		cp.followers 'company_followers', cp.company_id,
		case when pp.followers > cp.followers then 1 else 0 end as flag
	from
		personal_profiles pp
		inner join employee_company ec
		on pp.profile_id = ec.personal_profile_id
		inner join company_pages cp
		on ec.company_id = cp.company_id 
)
select profile_id from cte 
group by profile_id
having max(flag)=1
order by profile_id



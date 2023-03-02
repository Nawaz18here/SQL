
-- 3- Give Name Total Visits Most Visited Flooe Resource Used by emp

--create table entries ( 
--name varchar(20),
--address varchar(20),
--email varchar(20),
--floor int,
--resources varchar(10));

--insert into entries 
--values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
--,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR')


------------------------------------------------------------



select * from entries
go 

with
unique_resources as
	(
		Select distinct [name],resources as uniq_resouces_used from entries
	),
agg_resouces as (
		select [name],string_agg(uniq_resouces_used,',') as used_resouces
		from unique_resources group by name
),
	resources_used as 
	(
		select [name],count(1) as total_visit,string_agg(resources,',') as resouces_used from entries group by name
	)
, most_visited_floor as 
	(
		select [name],[floor],Count(1) as floor_count, Dense_Rank() Over(Partition By [name] order by Count(1) desc) as Rnk 
		from entries
		group by [name],[floor]
	)
Select r.[name],m.[floor], r.[total_visit],u.used_resouces from resources_used r
inner join most_visited_floor m
on r.[name]=m.[name]
inner join agg_resouces u
on u.[name]=r.[name]
where rnk=1


------------------------------------------------------------

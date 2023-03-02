
/*The problem is called as Most Popular Room Types*/

--create table airbnb_searches 
--(
--user_id int,
--date_searched date,
--filter_room_types varchar(200)
--);
--delete from airbnb_searches;
--insert into airbnb_searches values
--(1,'2022-01-01','entire home,private room')
--,(2,'2022-01-02','entire home,shared room')
--,(3,'2022-01-02','private room,shared room')
--,(4,'2022-01-03','private room')

Select * from airbnb_searches

SELECT value FROM STRING_SPLIT('red,green,,blue', ',');


--- USING STRING_SPLIT

select value, count(value) as cnt_search from (
Select date_searched , value from airbnb_searches cross apply STRING_SPLIT(filter_room_types, ',')
) a 
group by value


--- USING CASE 
with cte as (
Select 
SUM(case when filter_room_types like '%entire%' then 1 else 0 end) as ent,
SUM(case when filter_room_types like '%private%' then 1 else 0 end) as pri,
SUM(case when filter_room_types like '%shared%' then 1 else 0 end) as sha
from airbnb_searches
)
select 'Entire Home' as Room_type, ent from cte
union all 
select 'Shared Home', pri from cte
union all 
select 'Private Home', sha from cte



-- USING PIVOT

with cte as 
(
select 
[entire home] = sum(case when filter_room_types like '%entire home%' then 1 else 0 end),
[private room] = sum(case when filter_room_types like '%private room%' then 1 else 0 end),
[shared room] =sum(case when filter_room_types like '%shared room%' then 1 else 0 end)
from 
airbnb_searches
)
select
value,
cnt
from
cte
unpivot
(
 cnt for value in ([entire home],[private room],[shared room])
) as upvt
order by cnt desc




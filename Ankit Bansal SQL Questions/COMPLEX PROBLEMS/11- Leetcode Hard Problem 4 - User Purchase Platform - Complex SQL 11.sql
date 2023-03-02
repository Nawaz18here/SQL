

-- 11- Leetcode Hard Problem 4 | User Purchase Platform | Complex SQL 11

/* User purchase platform.
-- The table logs the spendings history of users that make purchases from an online shopping website which has a desktop 
and a mobile application.
-- Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only 
and both mobile and desktop together for each date.
*/

------------------------------------------------------------

--create table spending 
--(
--user_id int,
--spend_date date,
--platform varchar(10),
--amount int
--);

--insert into spending values(1,'2019-07-01','mobile',100),(1,'2019-07-01','desktop',100),(2,'2019-07-01','mobile',100)
--,(2,'2019-07-02','mobile',100),(3,'2019-07-01','desktop',100),(3,'2019-07-02','desktop',100);

------------------------------------------------------------

Select * from spending
order by spend_date,user_id,platform

------------------------------------------------------------

--USING CTE AND ENTERING DUMMY RECORD

with cte as
(
	select user_id,spend_date,max(platform) as platform, sum(amount) as total_amount
	from spending
	group by user_id, spend_date 
	having count(distinct platform ) = 1
	union all
	select user_id,spend_date,'Both' as platform, sum(amount) as total_amount
	from spending
	group by user_id, spend_date 
	having count(distinct platform ) = 2
	union all
	select distinct null as user_id ,spend_date,'Both' as platform, 0 as total_amount --DUMMY RECORD
	from spending
	group by user_id, spend_date 

)
select spend_date, platform, sum(total_amount ) as total_amount, count( user_id ) as total_users
from cte
group by spend_date,platform
order by spend_date,platform desc


------------------------------------------------------------
--USING CTE & STRING_AGG FUNCTION

WITH CTE AS
(
SELECT spend_date,STRING_AGG(platform,',') 'platform',SUM(amount) 'amount',user_id
FROM spending
GROUP BY spend_date,user_id
UNION ALL
SELECT spend_date,'both',0,NULL
FROM spending
)

SELECT spend_date,CASE WHEN platform='mobile,desktop' THEN 'both' ELSE platform END platform,
SUM(amount) 'total_amt',COUNT(DISTINCT user_id) 'total_users'
FROM CTE
GROUP BY spend_date,CASE WHEN platform='mobile,desktop' THEN 'both' ELSE platform END
ORDER BY 1


------------------------------------------------------------





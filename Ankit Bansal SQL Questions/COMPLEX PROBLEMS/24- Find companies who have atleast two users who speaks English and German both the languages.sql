

--24- Find companies who have atleast two users who speaks English and German both the languages

--create table company_users 
--(
--company_id int,
--user_id int,
--language varchar(20)
--);

--insert into company_users values (1,1,'English')
--,(1,1,'German')
--,(1,2,'English')
--,(1,3,'German')
--,(1,3,'English')
--,(1,4,'English')
--,(2,5,'English')
--,(2,5,'German')
--,(2,5,'Spanish')
--,(2,6,'German')
--,(2,6,'Spanish')
--,(2,7,'English');

------------------------------------------------------------

select * from company_users
go

------------------------------------------------------------

/*
I used a different approach for this problem, First I aggregated the languages speaks by user using String_agg function
and then filter only rows which have English and German using Like command.
Lastly used string_split and cross apply function to split the filtered data and applied count(distinct user_id) >=2 condition.
*/

with cte_agg as 
(
	select company_id,user_id,
	STRING_AGG(language,'-')
	within group (order by language) as all_language
	from company_users
	group by company_id,user_id
), cte2 as 
(
	select * from cte_agg
	where all_language like '%English%German%'
)
select company_id--, count(distinct user_id)
from cte2
cross apply string_split(all_language,'-') 
group by company_id
having count(distinct user_id) >=2


------------------------------------------------------------

--USING SIMPLE GROUP AND HAVING

with cte as (
	select company_id,user_id,  count(1) as cnt
	from company_users
	where language in ('English','German')
	group by company_id,user_id
	having count(1)=2
)
select company_id
from cte
group by company_id
having count(1)>=2

------------------------------------------------------------


select * from company_users
go

with temp as (
    select *, row_number() over (partition by user_id order by user_id) as rn
    from company_users
    where language in('English','German')
)
select company_id, count(user_id) as num_of_users
from temp
where rn > 1
group by company_id
having count(user_id) >= 2

-------------------------REVISION------------------------------------

select * from company_users
go

Select company_id from
	(
		Select company_id, user_id,count(1) as Cnt_Language from 
		company_users
		where language in ( 'English', 'German')
		group by company_id,user_id 
	) a
where Cnt_Language = 2
group by company_id
having count(1) >= 2


------------------------------------------------------------


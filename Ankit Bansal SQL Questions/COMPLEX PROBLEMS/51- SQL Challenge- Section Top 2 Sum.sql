
--51- SQL Challenge- Section Top 2 Sum
/*
Problem statement : we have a table which stores data of multiple sections. every section has 3 numbers
we have to find top 4 numbers from any 2 sections(2 numbers each) whose addition should be maximum
so in this case we will choose section b where we have 19(10+9) then we need to choose either C or D
because both has sum of 18 but in D we have 10 which is big from 9 so we will give priority to D.
*/

--create table section_data
--(
--section varchar(5),
--number integer
--)
--insert into section_data
--values ('A',5),('A',7),('A',10) ,('B',7),('B',9),('B',10) ,('C',9),('C',7),('C',9) ,('D',10),('D',3),('D',8);


--insert into section_data
--values ('E',15),('E',8),('E',10) ,('F',20),('F',1),('F',6) ,('G',1),('G',19),('G',9) ,('H',0),('H',20),('H',8);


------------------------------------------------------------
select * from section_data


go
with cte_rnk as (
	Select *,rank() over(partition by section order by number desc ) as d_num
	from section_data
	)
,cte_sum as (
	Select *,
	sum(number) over(partition by section order by number desc rows between unbounded preceding and unbounded following ) as sum_two_nums
	,row_number() over(order by section,number desc ) as d_row
	from cte_rnk
	where d_num<3
)
, cte_grp as (
Select *,ntile(2) over(order by d_row) as d_grp from cte_sum
)
, cte_fnl as (
select *,max(sum_two_nums) over(partition by d_grp) as max_two_nums
from cte_grp )

Select section,number
from cte_fnl
where max_two_nums = sum_two_nums
group by section,number
having count(number)=1
order by section, number

------------------------------------------------------------

select * from section_data

----------------------------------------------------------

go
with cte as (
select *,row_number() over(partition by section order by number desc) as d_row from section_data
)
,cte2 as (
select *,sum(number) over(partition by section) as d_sum
,max(number) over(partition by section) as d_max
from cte
where d_row<3
),
cte3 as (
select *,dense_rank() over(order by d_sum desc,d_max desc ) as d_dn
from cte2)
select * from cte3 where d_dn<3


------------------------------------------------------------

with cte as (
select *, 
dense_rank() over(partition by section order by number desc) as dnk
, SUM(number) over(partition by section order by number desc rows between unbounded preceding and current row) as RollingSum
, row_number() over(partition by section order by section) as rn
from section_data)

,filter_sections as (
select a.section as a, b.section as b, a.number as a_no, b.number as b_no, a.RollingSum as a_sum, b.RollingSum as b_sum
from cte a 
inner join cte b on a.dnk = b.dnk and a.number > b.number
where a.rn <=2 and b.rn <=2 and a.dnk = 2 )

,sections as (
select a as section, a_sum as Rolling_sum
from filter_sections 
union
select b, b_sum
from filter_sections )

select A.section, B.number from (
select section, Rolling_sum, dense_rank() over(order by Rolling_sum desc) as dnk
from sections ) A
inner join cte B on A.section = B.section 
where A.dnk <=2 and B.dnk <=2;


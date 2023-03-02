
--40- Find the Quiet Students in All Exams

--create table studentsQ
--(
--student_id int,
--student_name varchar(20)
--);
--insert into studentsQ values
--(1,'Daniel'),(2,'Jade'),(3,'Stella'),(4,'Jonathan'),(5,'Will');

--create table examsQ
--(
--exam_id int,
--student_id int,
--score int);

--insert into examsQ values
--(10,1,70),(10,2,80),(10,3,90),(20,1,80),(30,1,70),(30,3,80),(30,4,90),(40,1,60)
--,(40,2,70),(40,4,80);

--------------------------------------------------------------

select * from studentsQ

select * from examsQ

--------------------------------------------------------------

--USING DENSE_RANK()

go
with cte as (
	select *,dense_rank() over(partition by exam_id 
	order by score desc ) as dn_desc,
	dense_rank() over(partition by exam_id 
	order by score asc ) as dn_asc
	from examsQ
	)
select distinct s.student_id, s.student_name
from cte c
inner join studentsQ s
on c.student_id = s.student_id
where s.student_id not in (
	select distinct student_id from cte 
	where dn_desc = 1 or dn_asc = 1
)

--------------------------------------------------------------

--USING GROUP BY AND HAVING WITH CASE WHEN 

with cte as (
	select exam_id,student_id,score,
	min(score) over(partition by exam_id ) as min_score
	,max(score ) over(partition by exam_id ) as max_score
	from examsQ
)
select c.student_id,max(s.student_name) as student_name
--, case when score = min_score or score = max_score then 1 else 0 end as red_flag
from cte c
inner join studentsQ s
on s.student_id = c.student_id
group by c.student_id
having max(case when score = min_score or score = max_score 
then 1 else 0 end) = 0 


--------------------------------------------------------------


--USING max and min 

with exams_min_max as (
select e.* ,
max(e.score) over (partition by e.exam_id) 
as max_score,
min(e.score) over (partition by e.exam_id) as min_score
from examsQ e
)
select distinct e.student_id
from examsQ e
where e.student_id not in 
(
select student_id from exams_min_max emm
where emm.max_score=emm.score or emm.min_score=emm.score
)

--------------------------------------------------------------

--USING GROUP BY

with cte1 as(
select *,min(score) over(partition by exam_id order by score)  as first_val,
max(score) over(partition by exam_id order by score desc)  as last_val
from examsQ
)
, cte2 as(
select *,case when (score <>first_val and score <> last_val) then 1 else null end as final_count from cte1
)

select student_id--,count(student_id),count(final_count) from cte2
group by student_id
having (count(student_id))=(count(final_count))


--------------------------------------------------------------

--USING FIRST AND LAST VALUE 

with cte as (select *,
FIRST_VALUE(score) over(partition by exam_id order by score desc) as hig,
FIRST_VALUE(score) over(partition by exam_id order by score asc) as low
from examsQ)
select cte.student_id,s.student_name
--,case when score = hig OR score = low then 1 else 0 end
from cte
INNER JOIN studentsQ s on cte.student_id=s.student_id
group by cte.student_id,s.student_name
having max(case when score = hig OR score = low then 1 else 0 end)=0

--------------------------------------------------------------

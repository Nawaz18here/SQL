
--3- 4 Tricky SQL Problems

--CREATE TABLE [students](
-- [studentid] [int] NULL,
-- [studentname] [nvarchar](255) NULL,
-- [subject] [nvarchar](255) NULL,
-- [marks] [int] NULL,
-- [testid] [int] NULL,
-- [testdate] [date] NULL
--)
----data:
--insert into students values (2,'Max Ruin','Subject1',63,1,'2022-01-02');
--insert into students values (3,'Arnold','Subject1',95,1,'2022-01-02');
--insert into students values (4,'Krish Star','Subject1',61,1,'2022-01-02');
--insert into students values (5,'John Mike','Subject1',91,1,'2022-01-02');
--insert into students values (4,'Krish Star','Subject2',71,1,'2022-01-02');
--insert into students values (3,'Arnold','Subject2',32,1,'2022-01-02');
--insert into students values (5,'John Mike','Subject2',61,2,'2022-11-02');
--insert into students values (1,'John Deo','Subject2',60,1,'2022-01-02');
--insert into students values (2,'Max Ruin','Subject2',84,1,'2022-01-02');
--insert into students values (2,'Max Ruin','Subject3',29,3,'2022-01-03');
--insert into students values (5,'John Mike','Subject3',98,2,'2022-11-02');

------------------------------------------------------------------

-- 1. Get list of student who scored above avg marks in each subject

select * from students

----USING AVG with OVER() Clause

Select distinct studentname from (
select *,avg(marks) over(Partition by subject) as avg_sub_marks from students
) a where marks>a.avg_sub_marks


----USING CTE and GROUP BY 

With CTE as 
	(
		select subject,avg(marks) as avg_sub_marks
		from students group by subject
	)
Select s.*,c.* from students s
inner join cte c on s.subject=c.subject
where s.marks>c.avg_sub_marks



------------------------------------------------------------

-- 2. SQL query to get the percentage of students who score more
-- than 90 in any subject amongst the total student


--LONG Method using CTE

go
with cte as (
Select count(Distinct studentid) as cnt_90above
from students where marks>90
) , cte2 as (
Select count(Distinct studentid) as cnt_all
from students 
) 
Select (c.cnt_90above*1.0 / c2.cnt_all) * 100
from cte c,cte2 c2

--USING CASE WHEN 
Select 
(count(distinct case when marks>90 then studentid else null end)*1.0
/count(distinct studentid) * 100) as PERCENTAGE
from students 

------------------------------------------------------------


-- 3. SQL Query to get 2nd highest and 2nd lowest marks for each subject

--WRONG APPROACH Below , here subject3 rows doesnt come

select b.subject,max(marks) as '2nd_max_marks',
min(marks) as '2nd_min_marks'
from 
	( 
	select a.*,s.marks from students s inner join 
		(
			select subject,max(marks) as max_marks,min(marks) as min_marks
			from students
			group by subject
		) a on s.subject = a.subject 
	where s.marks <> a.max_marks and s.marks <> a.min_marks
	) b
group by b.subject


select * from students
go
--USING CTE AND WINDOW FUNCTION 

With cte as (
	select *,
	DENSE_RANK() over ( Partition by subject order by marks desc ) as hig_rnk,
	DENSE_RANK() over ( Partition by subject order by marks asc ) as low_rnk
	from students
	)
Select subject,
max(case when c.hig_rnk = 2 then marks else null end )as sec_hig,
max(case when c.low_rnk = 2 then marks else null end )as sec_low
from cte c
group by subject


-- 4. For each student and test, identify if their marks increased or decreased

Select 
	studentname,
	subject,
	marks,
	prev_marks, 
	marks-Prev_marks as diff, 
case
	when marks-Prev_marks > 0 then 'Increased' 
	when marks-Prev_marks < 0 then 'Decreased' 
	else 'First Subject ' end as comment
from 
(
	select *,Lag(marks) over(partition by studentid
	order by subject) as Prev_marks from students
) a


------------------------------------------------------------

go
with cte_marks as (
	select *,lag(marks) over(partition by studentid order by subject)
	as next_test_marks
	from students
	)
Select *, 
case when c.next_test_marks > c.marks then 'Decreased'
 when  c.next_test_marks < c.marks then 'Increased'
else 'First Subject' end as Comment
from cte_marks c




------------------------------------------------------------

----------------------PRACTICE--------------------------------------

select * from students

-- 1. Get list of student who scored above avg marks
--in each subject

Select distinct studentname from (
select *,avg(marks) over(partition by subject) as avg_sub
from students ) a 
where marks > a.avg_sub

------------------------------------------------------------

-- 2. SQL query to get the percentage of students who score more
-- than 90 in any subject amongst the total student


select * from students

go
with student_mark as (
	Select count(1) as cnt_marks from (
	select studentid from students group by studentid
	having max(marks)>90 ) a
),
student_all as (
select count(distinct studentid) as cnt_all from students
)
Select cnt_marks *1.0/  cnt_all *100
from student_mark,student_all



Select 
--count(distinct case when marks>90 then studentid else null end),count(distinct studentid) 
( count(distinct case when marks>90 then studentid else null end)
*1.0 / count(distinct studentid) *100 ) as PERCENTAGE
from students 

------------------------------------------------------------

-- 3. SQL Query to get 2nd highest and 
-- 2nd lowest marks for each subject


select * from students

go
with cte as
(
	select *,DENSE_RANK() over(partition
	by subject order by marks desc ) as d_desc,
	DENSE_RANK() over(partition
	by subject order by marks asc ) as d_asc,
	count(1) over(partition by subject) as sub_cnt
	from students
)
Select subject,
sum(case when d_desc = 2 then marks end ) as 'second_highest',
sum(case when d_asc = 2 then marks end ) as 'second_lowest'
from cte c
group by subject

------------------------------------------------------------

-- 4. For each student and test, identify if
-- their marks increased or decreased


go
with cte_marks as (
	select *,lag(marks) over(partition by studentid order by subject)
	as next_test_marks
	from students
	)
Select *, 
case when c.next_test_marks > c.marks then 'Decreased'
 when  c.next_test_marks < c.marks then 'Increased'
else 'First Subject' end as Comment
from cte_marks c







------------------------------------------------------------
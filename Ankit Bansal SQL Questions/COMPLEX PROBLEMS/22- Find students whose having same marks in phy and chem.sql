
-- 10- Find students whose having same marks in phy and chem.
--Deadly Combination of Group By and Having Clause in SQL 


--create table exams (student_id int, subject varchar(20), marks int);
--delete from exams;
--insert into exams values (1,'Chemistry',91),(1,'Physics',91)
--,(2,'Chemistry',80),(2,'Physics',90)
--,(3,'Chemistry',80)
--,(4,'Chemistry',71),(4,'Physics',54);

------------------------------------------------------------
select * from exams
------------------------------------------------------------


select student_id from exams
group by student_id
having count(distinct subject) = 2 and count(distinct marks) = 1


------------------------------------------------------------

select student_id from exams
group by student_id
having count(distinct subject) = 2 and sum(marks) = 2*max(marks)


------------------------------------------------------------

select  e.student_id
from exams e 
join exams e2
on e.marks = e2.marks 
and e.subject = 'Chemistry' 
and e2.subject = 'Physics'



----------------------PRACTICE--------------------------------------


Select * from exams

Select student_id
from exams
group by student_id
having count(distinct subject) = 2 and sum(marks) = 2 * max(marks)


------------------------------------------------------------

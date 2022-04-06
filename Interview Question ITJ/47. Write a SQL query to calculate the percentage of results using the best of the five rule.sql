--47. Write a SQL query to calculate the percentage of results using the best of the five rule 
--i.e. You must take the top five grades for each student and calculate the percentage.


--Problem Statement :- For the 2021 academic year, students have appeared in the SSC exam. 

---------------------------------------------------------------------------
--create table SSC_Exam (
--Id int,
--English int,
--Maths int,
--Science int,
--Geography int,
--History int,
--Sanskrit int)

--Insert into SSC_Exam Values (1,85,99,92,86,86,99)
--Insert into SSC_Exam Values (2,81,82,83,86,95,96)
--Insert into SSC_Exam Values (3,76,55,76,76,56,76)
--Insert into SSC_Exam Values (4,84,84,84,84,84,84)
--Insert into SSC_Exam Values (5,83,99,45,88,75,90)


--Select * from SSC_Exam
--go

With CTE as (
	Select ID, Subject, Marks from SSC_Exam
	 UNPIVOT
	 (
		Marks 
		for Subject in (English,Maths,Science,Geography,History,Sanskrit)
	 ) Pvt_Tbl
 ), 
 CTE2 as (
	 Select ID, Marks, ROW_Number() Over (Partition by ID order by Marks DESC ) as Rnk
	 from CTE  
 ), 
 CTE3 as (
 Select ID, CAST ( SUM(MARKS)/500.0 as FLOAT ) * 100 as Perc from CTE2  where rnk<= 5 group by ID  
 )

 Select S.ID,English,Maths,Science,Geography,History,Sanskrit,Perc
 from CTE3 C3
 INNER JOIN SSC_Exam S on C3.ID=S.ID


--27. Write a SQL query to print the Sequence Number from the given range of number.

--Create Table SampleTable
--(
--Start_Range Bigint,
--End_Range Bigint
--);
--Insert into SampleTable Values (1,4)
--Insert into SampleTable Values (6,6)
--Insert into SampleTable Values (8,9)
--Insert into SampleTable Values (11,13)
--Insert into SampleTable Values (15,15)

select * from SampleTable
go 
--USING CTE 

With CTE as (
Select Start_Range, End_Range from SampleTable

Union all

Select Start_Range+1 , End_Range from CTE where Start_Range+1<=End_Range )

Select Start_Range from CTE order by start_range


--DROP TABLE SampleTable




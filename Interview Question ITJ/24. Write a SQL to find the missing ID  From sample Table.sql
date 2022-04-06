--24. Write a SQL to find the missing ID  From sample Table

--Create Table Sample_Table(
--ID int)
--Insert into Sample_Table Values (1),(4),(7),(9),(12),(14),(16),(17),(20)

--Select * from Sample_Table 

--USING TEMP TABLE
Declare @lower int, @Upper int
SELECT @Lower= MIN(ID) from Sample_Table
SELECT @Upper= MAx(ID) from Sample_Table
Create table #temp(ID int )
While ( @Lower<@Upper )
Begin
	IF (@Lower) NOT IN (Select ID from Sample_Table ) 
		insert into #temp
		Select @Lower
	Set @Lower = @lower + 1
END
Select * from #temp

--USING CTE 1 SOLUTON
With CTE_Numbers as 
(
  Select 1 as Firstvalue
  union all
  Select Firstvalue+1
  from CTE_Numbers
  where Firstvalue <20
)
select firstvalue from CTE_Numbers
except
Select id from Sample_Table


--USING CTE 2 SOLUTON
with cteSample as
(
select min(id) as start,  max(id) as stop from Sample_Table 

union all

select start+1 , stop from cteSample where (start + 1) <20
)
select start from cteSample where start not in(select id from sample_table)
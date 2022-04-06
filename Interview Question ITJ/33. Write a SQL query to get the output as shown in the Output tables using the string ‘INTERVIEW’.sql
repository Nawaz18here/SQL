--33. Write a SQL query to get the output as shown in the Output tables using the string ‘INTERVIEW’
With CTE as
(
Select 'INTERVIEW' as A, Len('INTERVIEW') as B

UNION all

Select Left(A,B-1) as A, B-1
from CTE 
where B-1>0
)
Select * from CTE


--b) Write a SQL query to get the output as shown in the Output tables using the string ‘INTERVIEW’

With CTE as
(
Select 'INTERVIEW' as A, 0 as D, 'INTERVIEW' as B
UNION all
Select Left(B,D+1) as A, D+1, B
from CTE 
where D<9
)
Select A,D from CTE where D<>0


---OTHER QUESTION
declare @var1 varchar(20), @intgr int, @i int;
set @var1 = 'INTERVIEW'
set @intgr =0
set @i = len(@var1)

while (@intgr<=@i)
begin

	print left(@var1,@intgr)
	set @intgr +=1
end



--20 to 1 USING CTE
With CTE3 as
(
Select 20 as D

UNION all

Select D-1
from CTE3 
where D-1> 0
)
Select * from CTE3


--1 to 20 USING CTE
With CTE4 as
(
Select 1 as D

UNION all

Select D+1
from CTE4
where D+1< 20
)
Select * from CTE4






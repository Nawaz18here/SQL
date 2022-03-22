With CTE as
(
Select 'INTERVIEW' as A, Len('INTERVIEW') as B

UNION all

Select Left(A,B-1) as A, B-1
from CTE 
where B-1>0
),
--b) Write a SQL query to get the output as shown in the Output tables using the string ‘INTERVIEW’
CTE2 as
(
Select 'INTERVIEW' as A, 1 as D, 'INTERVIEW' as B
UNION all
Select Left(B,D+1) as A, D+1, B
from CTE2
where D<9
)
Select * from CTE 
UNION ALL
Select A,D from CTE2 where D<>1
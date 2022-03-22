--Write a SQL query to get the name of string 'QUADIR NAWAZ' in descending and ascending order respectively
With CTE as
(
Select 'QUADIR NAWAZ' as A, Len('QUADIR NAWAZ') as B

UNION all

Select Left(A,B-1) as A, B-1
from CTE 
where B-1>0
),
CTE2 as
(
Select 'QUADIR NAWAZ' as A, 1 as D, 'QUADIR NAWAZ' as B, Len('QUADIR NAWAZ') as C

UNION all

Select Left(B,D+1) as A, D+1, B, C
from CTE2
where D<C
)
Select A as 'Beautiful Name' from CTE 
UNION ALL
Select A from CTE2 where D<>1
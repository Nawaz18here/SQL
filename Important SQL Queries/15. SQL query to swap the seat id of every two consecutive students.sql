--Write an SQL query to swap the seat id of every two consecutive students.
--If the number of students is odd, the id of the last student is not swapped.

--CREATE Table SwapName
--(
--ID INT Identity,
--EmpName Varchar(30)
--)

--INSERT INTO SwapName VALUES('Mark')
--INSERT INTO SwapName VALUES('John')
--INSERT INTO SwapName VALUES('Hira')
--INSERT INTO SwapName VALUES('Swati')
--INSERT INTO SwapName VALUES('Mary')

Select * from SwapName
go

------------------------------------------------------------
Select id, ISNULL(
Case when id %2=1 then Lead(Empname,1) over ( order by id )
Else Lag(Empname,1) over ( order by id ) END , Empname ) as Empname
from SwapName
go 

------------------------------------------------------------------
SELECT DENSE_RANK() OVER
(ORDER BY
CASE WHEN id % 2 = 1 THEN id+1 ELSE id-1 END
ASC) AS id, EmpName
FROM SwapName;


--Drop table SwapName
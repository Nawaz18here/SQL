--10. Display that record which consecutively appear 3 or more than 3 times

--CREATE TABLE Emp2(
--[id]  int identity,
--[num]  varchar )

--INSERT INTO Emp2 VALUES(1)
--INSERT INTO Emp2 VALUES(1)
--INSERT INTO Emp2 VALUES(1)
--INSERT INTO Emp2 VALUES(2)
--INSERT INTO Emp2 VALUES(1)
--INSERT INTO Emp2 VALUES(2)
--INSERT INTO Emp2 VALUES(2)
--INSERT INTO Emp2 VALUES(1)
--INSERT INTO Emp2 VALUES(1)
--INSERT INTO Emp2 VALUES(2)
--INSERT INTO Emp2 VALUES(2)

Select * from Emp2

--USING JOINS
select *
from Emp2 l1 
    join Emp2 l2 on l1.id=l2.id-1 
    join Emp2 l3 on l1.id=l3.id-2
where l1.num=l2.num and l2.num=l3.num


--USING CTE and LEAD, LAG Function
with c as (
select id, num, LEAD(num)over(order by id) LEAD, 
LAG(num)over(order by id) LAG from Emp2 )
    
select DISTINCT num ConsecutiveNums from c where (num=LEAD and num=LAG)


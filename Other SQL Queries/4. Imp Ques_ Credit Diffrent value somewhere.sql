
-- Drop table dec, jan
--Create Table Dec
--(
--         ColA int,
--		 ColB int,
--		 ColC int,
--)
--Go

--Create Table Jan
--(
--		 ColA int,
--		 ColB int,
--		 ColC int,
--)
--Go

--Insert into Dec Values (1,1,2)
--Insert into Dec Values (2,2,1)
--Insert into Dec Values (3,3,4)
--Go 

--Insert into Jan Values (1,1,4)
--Insert into Jan Values (2,2,1)
--Insert into Jan Values (3,3,2)
--Go

Select * from Dec
Select * from Jan

Select * from ( select * from Dec t1
EXCEPT
Select * from Jan t2 ) a 
UNION
 Select * from  (
select * from Jan t2
EXCEPT
Select * from Dec t1
) b










Select * from jan
except
Select * from dec














With CTE as (
Select * from jan
except
Select * from dec ) 
Select * from CTE
inner join Jan J
on CTE.Colc<>J.ColC





(
select * from Dec t1
EXCEPT
Select * from Jan t2
)
UNION
(
select * from Jan t2
EXCEPT
Select * from Dec t1
)


Select * from Jan J
inner join Dec D on J.ColA=D.ColA
Where J.ColA<>D.ColA or J.ColB<>D.ColB or J.ColC<>D.ColC


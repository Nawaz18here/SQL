--drop table TableB,TableA

--Create Table TableA
--(
--       ColumnA nvarchar(20)
--)
----Go

--Create Table TableB
--(
--       ColumnB nvarchar(20)
--)
--Go

--Insert into TableA Values (1)
--Insert into TableA Values (NULL)
--Go 

--Insert into TableB Values (1)
--Insert into TableB Values (1)

--Go


Select * from TableA
Select * from TableB

Select ColumnA, ColumnB
from TableA
inner join TableB
on TableA.ColumnA = TableB.ColumnB

Select ColumnA, ColumnB
from TableA
left outer join TableB
on TableA.ColumnA = TableB.ColumnB

Select ColumnA, ColumnB
from TableA
right outer join TableB
on TableA.ColumnA = TableB.ColumnB

Select ColumnA, ColumnB
from TableA
full outer join TableB
on TableA.ColumnA = TableB.ColumnB 

Select ColumnA, ColumnB
from TableA
cross join TableB
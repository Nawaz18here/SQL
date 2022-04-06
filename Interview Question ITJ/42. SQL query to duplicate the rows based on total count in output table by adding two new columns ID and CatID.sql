--42. Write a SQL query to duplicate the rows based on total count in output table by adding two new columns ID and CatID

--Problem Statement :- ITEM Table  has two columns namely ItemName and TotalQuantity. 

/*-------------------------------------------------------------------------
Table and Insert SQL Script :
-------------------------------------------------------------------------*/

--Create Table Item(
--ItemName Varchar(30),
--TotalQuantity int
--)
--Insert into Item Values('Apple',2)
--Insert into Item Values('Orange',3)


Select * from Item
GO

With CTE as (
Select  ItemName , 1 as CatID , TotalQuantity from Item
UNION ALL
Select ItemName , CatID+1 as CatId, TotalQuantity from CTE  Where CatID < TotalQuantity )

Select ROW_NUMBER() Over (Order by ItemName ) as ID, * from CTE order by ID



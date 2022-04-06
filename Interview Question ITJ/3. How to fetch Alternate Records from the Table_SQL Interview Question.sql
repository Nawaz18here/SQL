--3. How to fetch Alternate Records from the Table | SQL Interview Question

--Create Table Students(
--Id Varchar(10),
--Name Varchar(30),
--Gender Char(1)
--)


--Insert into Students Values ('S1001','James','M');
--Insert into Students Values ('S1002','Henry','M');
--Insert into Students Values ('S1003','Emma','F');
--Insert into Students Values ('S1004','David','M');
--Insert into Students Values ('S1005','Mary','F');
--Insert into Students Values ('S1006','Thomas','M');
--Insert into Students Values ('S1007','Daniel','M');
--Insert into Students Values ('S1008','Steven','M');
--Insert into Students Values ('S1009','Mark','M');
--Insert into Students Values ('S1010','Karen','F');


Select * from Students

Select * from (
Select *, Dense_Rank() Over ( order by ID) as DenseRank
from Students ) as C
where C.DenseRank % 2 =0

--Drop table Students

-------------------------------------------------------------------------------------------------------

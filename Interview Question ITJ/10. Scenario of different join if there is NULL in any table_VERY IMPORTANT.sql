--10th Question
--Problem Statements :- Scenario of different join if there is NULL in any table_VERY IMPORTANT

--CREATE TABLE Table_First(
--X int)

--CREATE TABLE Table_Second(
--Y int)

--INSERT INTO Table_First VALUES(9);
--INSERT INTO Table_First VALUES(8);
--INSERT INTO Table_First VALUES(NULL);

--INSERT INTO Table_Second VALUES(9);
--INSERT INTO Table_Second VALUES(9);
--INSERT INTO Table_Second VALUES(NULL);

Select * from Table_First
Select * from Table_Second

Select X,Y
from Table_First T1
Inner Join Table_Second T2
on T1.X=T2.Y

Select X,Y
from Table_First T1
Left Join Table_Second T2
on T1.X=T2.Y



--DROP TABLE Table_First,Table_Second
-------------------------------------------------------------------------------------------------------

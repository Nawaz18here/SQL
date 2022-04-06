----9th QUESTION 

----Write a SQL which will fetch total schedule of matches between each Team vs opposite team:

--Create Table Team(
--ID INT,
--TeamName Varchar(50)
--);

--INSERT INTO Team VALUES(1,'India'),(2,'Australia'),(3,'England'),(4,'NewZealand');

Select * from Team

Select (T1.TeamName + ' Vs ' +  T2.TeamName ) as Macthes from Team T1 Inner join Team T2 on T1.ID<T2.ID

--DROP TABLE Team
-------------------------------------------------------------------------------------------------------

--7. SQL Query to select Distinct Record without using DISTINCT keyword

--CREATE TABLE C
--(
--  id INT NOT NULL PRIMARY KEY IDENTITY,
--  someData INT
--)

--INSERT INTO C VALUES ( 1000)
--INSERT INTO C VALUES ( 1000)
--INSERT INTO C VALUES ( 2000)
--INSERT INTO C VALUES ( 3000)
--INSERT INTO C VALUES ( 4000)
--INSERT INTO C VALUES ( 3000)

--TABLE
Select someData from C
Go 

 --SELECT Distinct Reord with USING DISTINCT KEYWORD
Select Distinct someData from C
Go 

 --SELECT Distinct Reord without USING DISTINCT KEYWORD
With CTE as (
	Select Somedata, COUNT(Somedata) as Cnt from C
	group by Somedata
)
Select Somedata from CTE

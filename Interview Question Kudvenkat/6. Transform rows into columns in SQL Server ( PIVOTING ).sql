--6. QUESTION:

-- Transform rows into columns in SQL Server ( PIVOTING )

-- Visit this link for the explanation of question and answer:
-- https://www.youtube.com/watch?v=C0mQqDnF7wQ&list=PL6n9fhu94yhXcztdLO7i6mdyaegC8CJwR&index=6

-- TABLE SCRIPT


----SQL to create the table
--Create Table CountriesP
--(
-- Country nvarchar(50),
-- City nvarchar(50)
--)
--GO

--Insert into CountriesP values ('USA','New York')
--Insert into CountriesP values ('USA','Houston')
--Insert into CountriesP values ('USA','Dallas')

--Insert into CountriesP values ('India','Hyderabad')
--Insert into CountriesP values ('India','Bangalore')
--Insert into CountriesP values ('India','New Delhi')
--Insert into CountriesP values ('India','Kerala')

--Insert into CountriesP values ('UK','London')
--Insert into CountriesP values ('UK','Birmingham')
--Insert into CountriesP values ('UK','Manchester')
/*
Here is the interview question.
Write a sql query to transpose rows to columns. 
*/

--Select * from CountriesP

-- Added New Column SeqColumn in Query
--Select *, 
--		'City'+ CONVERT(Varchar(20), ROW_NUMBER() over (Partition by Country order by Country)) as SeqColumn
--from CountriesP


Select Country,City1, City2, City3,City4
FROM (
	Select *, 
		'City'+ CONVERT(Varchar(20), ROW_NUMBER() over (Partition by Country order by Country)) as SeqColumn
	from CountriesP

) Temp
PIVOT (
		Max(City)
		For SeqColumn in (City1,City2,City3,City4)

) PIV











--17. QUESTION:

--  How and why a sql inner left right full and cross join returns the same row count

-- Visit this link for the explanation of question and answer:
-- https://www.youtube.com/watch?v=rRAiUdmcJEs&list=PL6n9fhu94yhXcztdLO7i6mdyaegC8CJwR&index=17

-- TABLE SCRIPT

--CREATE TABLE TableA
--(
--ColumnA int
--)


--CREATE TABLE TableB
--(
--ColumnB int
--)

--INSERT INTO TableA (ColumnA)
--Values (1), (1)


--INSERT INTO TableB (ColumnB)
--Values (1), (1), (1)


Select * from TableA
Select * from TableB

--INNER JOIN
Select T1.ColumnA, T2.ColumnB
From TableA T1
Inner Join TableB T2
On T1.ColumnA= T2.ColumnB


-- LEFT JOIN
Select T1.ColumnA, T2.ColumnB
From TableA T1
left Join TableB T2
On T1.ColumnA= T2.ColumnB


--CREATE TABLE TableC
--(
--ColumnC int,
--SomeValC varchar(2)
--)
--GO

--CREATE TABLE TableD
--(
--ColumnD int,
--SomeValD varchar(2)
--)
--GO

--INSERT INTO TableC (ColumnC,SomeValC)
--Values (1,'C1'), (1, 'C2')

--INSERT INTO TableD (ColumnD,SomeValD)
--Values (1,'D1'), (1, 'D2'),(1, 'D3')


Select * from TableC
Select * from TableD


-- LEFT JOIN
Select T1.ColumnC,T1.SomeValC, T2.ColumnD, T2.SomeValD
From TableC T1
left Join TableD T2
On T1.ColumnC= T2.ColumnD

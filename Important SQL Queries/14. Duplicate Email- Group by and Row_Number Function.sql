--CREATE Table TblEmail
--(
--Name nvarchar(20),
--Email nvarchar(20)
--)

--INSERT INTO TblEmail VALUES('A','a@agmail.com')
--INSERT INTO TblEmail VALUES('A','a@agmail.com')
--INSERT INTO TblEmail VALUES('B','b@bgmail.com')
--INSERT INTO TblEmail VALUES('A','a@agmail.com')
--INSERT INTO TblEmail VALUES('C','c@cgmail.com')
--INSERT INTO TblEmail VALUES('C','c@cgmail.com')
--INSERT INTO TblEmail VALUES('D','d@dgmail.com')
--INSERT INTO TblEmail VALUES('E','e@egmail.com')
--INSERT INTO TblEmail VALUES('E','e@egmail.com')

Select * from TblEmail

--Using Group By and Count
Select Name from TblEmail group by Name having ( COUNT(*) >1)

--Using Row_Number()
Select Distinct Name from (
Select Name,Row_Number() over(Partition by Email order by Name) as [CountofMail] from TblEmail ) as S
where S.CountofMail>1
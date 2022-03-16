--11. How to create list of names of customers who have exceed the number of transactions in day and transaction limit
 
--CREATE TABLE EmpDetail(
--[name]  nvarchar(50),
--[Amount]  int,
--[day] datetime )

----------------------------------------------
--INSERT INTO EmpDetail VALUES('hemanth',10000,'2019-06-21')
--INSERT INTO EmpDetail VALUES('hemanth',1000,'2019-06-21')
--INSERT INTO EmpDetail VALUES('hemanth',5000,'2019-06-21')
--INSERT INTO EmpDetail VALUES('hemanth',10000,'2019-07-21')
--INSERT INTO EmpDetail VALUES('kumar',100,'2019-06-21')
--INSERT INTO EmpDetail VALUES('kumar',5000,'2019-06-21')
--INSERT INTO EmpDetail VALUES('kumar',1000,'2019-07-21')
--INSERT INTO EmpDetail VALUES('kiranmai',10000,'2019-06-21')
--INSERT INTO EmpDetail VALUES('kiranmai',500,'2019-07-21')
--INSERT INTO EmpDetail VALUES('kiranmai',10000,'2019-06-21')


-- Table 2 contains transcation limit per day & transcation amount limit

--CREATE TABLE EmpLimit(
--[tranlimperday] int,
--[transamountlimit] int )
--INSERT INTO EmpLimit VALUES(3,10000)


select * from EmpDetail
select * from EmpLimit
go 

With C as (
select name,[day],SUM(Amount) as TrnAmt,count(*) as TrnCnt from EmpDetail  group by name,[day]
  )
Select Distinct [name] from C join EmpLimit L on C.TrnCnt>L.tranlimperday or C.TrnAmt>L.transamountlimit




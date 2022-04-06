--22. Write SQL to get Total  sales amount in USD for each sales date

--Create Table Sales_Table(
--Sales_Date Date,
--Sales_Amount Bigint,
--Currency Varchar(10)
--)

--INSERT INTO Sales_Table Values ('2020-01-01',500,'INR');
--INSERT INTO Sales_Table Values ('2020-01-01',100,'GBP');
--INSERT INTO Sales_Table Values ('2020-01-02',1000,'INR');
--INSERT INTO Sales_Table Values ('2020-01-02',500,'GBP');
--INSERT INTO Sales_Table Values ('2020-01-03',500,'INR');
--INSERT INTO Sales_Table Values ('2020-01-17',200,'GBP');

--CREATE TABLE [dbo].[ExchangeRate_Table](
-- [Source_Currency] [varchar](10) ,
-- [Target_Currency] [varchar](10),
-- [Exchange_Rate] [float] ,
-- [Effective_Start_Date] [date] 
--) 

--INSERT [dbo].[ExchangeRate_Table] VALUES ('INR','USD', 0.014,'2019-12-31')
--INSERT [dbo].[ExchangeRate_Table] VALUES ('INR','USD', 0.015,'2020-01-02')
--INSERT [dbo].[ExchangeRate_Table] VALUES ('GBP','USD', 1.32, '2019-12-20')
--INSERT [dbo].[ExchangeRate_Table] VALUES ('GBP','USD', 1.3, '2020-01-01' )
--INSERT [dbo].[ExchangeRate_Table] VALUES ('GBP','USD', 1.35, '2020-01-16')

--Select * from Sales_Table 
--go
--Select *  from ExchangeRate_Table

With CTE as
(
Select * , ISNULL(Lead(Dateadd(day,-1,Effective_Start_Date)) over (Partition by Source_Currency order by source_currency),'9999-12-31') Eff_End_Date
from ExchangeRate_Table 
)
Select Sales_Date, SUM(S.Sales_Amount * C.Exchange_rate ) as [Total Sales in USD]
from CTE C 
inner join Sales_Table S
on S.Currency = C.Source_Currency
where S.Sales_Date BETWEEN C.Effective_Start_Date and C.Eff_End_Date
group by Sales_Date

--DROP TABLE Sales_Table,ExchangeRate_Table
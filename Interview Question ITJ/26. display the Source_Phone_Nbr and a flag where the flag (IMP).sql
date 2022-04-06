--26.Write a SQL to display the Source_Phone_Nbr and a flag where the flag needs to be set to
--‘Y’ if first called number and last called number are the same and ‘N’ if first called number and last called number are different

--Create Table Phone_Log(
--Source_Phone_Nbr Bigint,
--Destination_Phone_Nbr Bigint,
--Call_Start_DateTime Datetime) ;

--Insert into Phone_Log Values (2345,6789,'2012-07-01 10:00')
--Insert into Phone_Log Values (2345,1234,'2012-07-01 11:00')
--Insert into Phone_Log Values (2345,4567,'2012-07-01 12:00')
--Insert into Phone_Log Values (2345,4567,'2012-07-01 13:00')
--Insert into Phone_Log Values (2345,6789,'2012-07-01 15:00')
--Insert into Phone_Log Values (3311,7890,'2012-07-01 10:00')
--Insert into Phone_Log Values (3311,6543,'2012-07-01 12:00')
--Insert into Phone_Log Values (3311,1234,'2012-07-01 13:00')

select * from Phone_Log;

--1st Solution
Select DISTINCT Source_Phone_Nbr, Case when First_1=Last_1 then 'Y' else 'N' ENd as Matched from  (
select *, FIRST_VALUE(Destination_Phone_Nbr) Over (Partition by Source_Phone_Nbr order by Source_Phone_Nbr ) as First_1,
LAST_VALUE(Destination_Phone_Nbr) Over (Partition by Source_Phone_Nbr order by Source_Phone_Nbr ) as Last_1
from Phone_Log
) a


--2nd Solution
with cte as
(
select *, DENSE_RANK() over (partition by source_phone_nbr order by call_start_datetime) as rn
from Phone_Log
)
,cte1 as
(
select *,min(rn) over (partition by source_phone_nbr) as mi
,max(rn) over (partition by source_phone_nbr) as ma
from cte
)
,cte2 as
(
select source_phone_nbr, count(distinct(destination_phone_nbr)) as cnt from cte1 where rn = mi or rn = ma
group by source_phone_nbr
)
select *, source_phone_nbr, case when cnt = 1 then 'Y' else 'N' end as Is_Match
from cte2



--3rd Solution
Select source_phone_nbr, Case when FirstCall=LastCall then 'Y' else 'N' end as IS_Match
from (
Select source_phone_nbr, MAX(Case when Firstrnk=1 then Destination_Phone_Nbr else null end ) as FirstCall,
Max(Case when Lastrnk=1 then Destination_Phone_Nbr else null end ) as LastCall
from (
select *, ROW_NUMBER() over ( partition by source_phone_nbr order by Call_Start_DateTime ) as Firstrnk,
ROW_NUMBER() over ( partition by source_phone_nbr order by Call_Start_DateTime desc ) as Lastrnk
from Phone_Log
) a
group by source_phone_nbr ) b


--drop table Phone_Log

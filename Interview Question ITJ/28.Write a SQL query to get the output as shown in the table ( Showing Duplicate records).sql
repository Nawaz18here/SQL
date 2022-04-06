--28.Write a SQL query to get the output as shown in the table ( Showing Duplicate records)

--Create Table Sample_1
--(
--X Bigint,
--Y Bigint,
--Z Bigint)

--Insert into Sample_1 Values (200,400,1);
--Insert into Sample_1 Values (200,400,2);
--Insert into Sample_1 Values (200,400,3);
--Insert into Sample_1 Values (10000,60000,1);
--Insert into Sample_1 Values (500,600,1);
--Insert into Sample_1 Values (500,600,2);
--Insert into Sample_1 Values (20000,80000,1);


Select * from Sample_1

Select X,Y,Z from 
(
Select * , Count(x) over (partition by x ) as cnt
from Sample_1 
) a 
where cnt>1



--drop table Sample_1

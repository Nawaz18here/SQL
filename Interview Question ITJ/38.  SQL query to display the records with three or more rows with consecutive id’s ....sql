--38.
--Write a SQL query to display the records with three or more rows with consecutive id’s 
--and the number of people is greater than or equal to 100. Return the result table ordered by Visit_Date

--Create Table Stadium(
--id int,
--Visit_Date Date,
--No_Of_People Bigint)

--Insert into Stadium Values(1,'2018-01-01',10)
--Insert into Stadium Values(2,'2018-01-02',110)
--Insert into Stadium Values(3,'2018-01-03',150)
--Insert into Stadium Values(4,'2018-01-04',98)
--Insert into Stadium Values(5,'2018-01-05',140)
--Insert into Stadium Values(6,'2018-01-06',1450)
--Insert into Stadium Values(7,'2018-01-07',199)
--Insert into Stadium Values(8,'2018-01-09',125)
--Insert into Stadium Values(9,'2018-01-10',88)

--select * from Stadium 

-- USING CTE

With CTE as 
(
select * from Stadium WHERE NO_OF_PEOPLE > 100 
)
, CTE2 as 
(
Select *, rank() over (order by id) as RNk, ID-RANK() OVER (ORDER BY ID) SEQ from CTE
), 
CTE3 as ( Select *, COUNT(SEQ) Over (partition by SEQ) CNT from CTE2 C 
)
Select Id,Visit_date,no_of_people from CTE3 C where CNT>3

--DROP TABLE Stadium


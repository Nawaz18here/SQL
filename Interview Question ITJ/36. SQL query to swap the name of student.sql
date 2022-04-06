--36. SQL query to swap the name of student 

--Create Table SeatArrangement (
--ID int,
--StudentName Varchar(30)
--)

--Insert into SeatArrangement Values (1,'Emma')
--Insert into SeatArrangement Values (2,'John')
--Insert into SeatArrangement Values (3,'Sophia')
--Insert into SeatArrangement Values (4,'Donald')
--Insert into SeatArrangement Values (5,'Tom')

Select * from SeatArrangement


Select ID,ISNULL(
CASE when (ID%2=1) then lead(StudentName) over(Order by id) else lag(StudentName) over(Order by id) end, StudentName) as StudentName 
from SeatArrangement

--DROP TABLE SeatArrangement



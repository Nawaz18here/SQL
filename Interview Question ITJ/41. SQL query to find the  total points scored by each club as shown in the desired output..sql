----41. Write a SQL query to find the  total points scored by each club as shown in the desired output.

----Problem Statement :-  Club Table has three columns namely Club_ID, Member_id and EDU.
----Same member can be a part of different club.  The EDU column has different rewards. The points for these awards are as follows :-
----MM – 0.5, CI – 0.5, CO- 0.5, CD – 1, CL-1, CM – 1
----

----Club_Id Reward
----1001 4.0
----1002 6.0
----1003 NULL

--Create Table Club (
--Club_Id int,
--Member_Id int,
--EDU varchar(30))

--Insert into Club Values (1001,210,Null)
--Insert into Club Values (1001,211,'MM:CI')
--Insert into Club Values (1002,215,'CD:CI:CM')
--Insert into Club Values (1002,216,'CL:CM')
--Insert into Club Values (1002,217,'MM:CM')
--Insert into Club Values (1003,255,Null)
--Insert into Club Values (1001,216,'CO:CD:CL:MM')
--Insert into Club Values (1002,210,Null)


/*
IF STRING_SPLIT gives Error then you change the compatiblity
select value from STRING_SPLIT('apple,banana,lemon,kiwi,orange,coconut',',')

Make sure that the database compatibility level is 130
You can use the following query to change it:
ALTER DATABASE [DatabaseName] SET COMPATIBILITY_LEVEL = 130
As mentioned in the comments, you can check the current compatibility level of a database using the following command:
SELECT compatibility_level FROM sys.databases WHERE name = 'Your-Database-Name';
*/


Select * from Club

--USING SUB-QUERY

Select Club_ID,  SUM( CASE WHEN EDU2 IN ( 'MM' , 'CI' , 'CO' ) then 0.5
						   WHEN EDU2 IN ( 'CD', 'CL' , 'CM' ) then 1 END ) AS Reward
from
	(
	SELECT Club_Id,Member_id,Value as EDU2 FROM Club P
	OUTER APPLY string_split(P.EDU,':') 
	) Sub
GROUP BY CLUB_ID


--USING CTE
WITH CTE AS
(
	Select *,  CASE EDU2 When 'MM' then 0.5 When 'CI' then 0.5 When 'CO' then 0.5
	When 'CD' then 1 When 'CL' then 1 When 'CM' then 1 END AS VAL
	from
	(
	SELECT Club_Id,Member_id,Value as EDU2 FROM Club P
	OUTER APPLY string_split(P.EDU,':') 
	) Sub
)
Select club_id,SUM(VAL) from Cte
GROUP BY CLUB_ID






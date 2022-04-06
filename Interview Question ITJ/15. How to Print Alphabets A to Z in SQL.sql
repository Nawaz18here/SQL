--15. How to Print Alphabets A to Z in SQL

--Select ASCII('A')
--Select CHAR(65)

--USING NORMAL WHILE LOOP
Declare @Start_Num int, @End_Num Int, @Letter nvarchar(4)
Select @Start_Num  =  ASCII('A'), @End_Num =  @Start_Num+26

While (@Start_Num < @End_Num )
BEGIN
	Select @Letter = CHAR(@Start_Num)
	PRINT @Letter
	Set @Start_Num= @Start_Num+1
END

--USING CTE

With CTE as
(
Select (CHAR(ASCII('A'))) as Letter
UNION ALL
SELECT (CHAR(ASCII(letter)+1)) from CTE
where Letter<>'Z'
)
select * from CTE
--17. How to print Fibonacci Series in SQL Server

-- USING LOOP 
Declare @FrstNum int, @ScndNum int, @LatestSum int, @Range int
Select @FrstNum=0, @ScndNum=1,@range=50, @LatestSum=0
While (@LatestSum<@Range)
	Begin
		if (@LatestSum<@Range)
		Print @LatestSum
		Set @LatestSum=@FrstNum+@ScndNum
		Set @FrstNum=@ScndNum
		Set @ScndNum=@LatestSum
	END

-- USING CTE and STRING_AGG() FUNCTION
With CTE as (
Select 0 as FirstN, 1 as ScndN, 1 as Step 
Union all
Select ScndN as FirstN,ScndN+FirstN as ScndN,Step+1 as Step from CTE where Step<10
)

SELECT STRING_AGG (FirstN,' , ')  AS Result FROM CTE

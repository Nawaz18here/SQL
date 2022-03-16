--2. Generating Random numbers using RAND() Function and inserting those random datas in the table

IF (Exists ( Select * from INFORMATION_SCHEMA.TABLES where Table_name='TempA' ))
	Begin
		Print 'Yes, This table is present here, so imma delete it first!'
		Drop Table TempA
		Print 'The desired table is successfully deleted!'
	END
Else
	Begin
		Create table TempA 
		( Id int identity primary key,
		[Name] nvarchar(15)
		) 

		Print 'Now, The Same Table is created again, I will fill some random values here as well'
		Declare @ProdRand int,@UpperA int, @LowerA int, @IdA Int
		Select @UpperA=100, @LowerA=2, @IdA=1
		

		While (@idA<=50)
			begin	
				Select @ProdRand = Round( ((@UpperA - @LowerA ) * rand() + 1 ) , 0 )
		
				Insert into TempA Values ('Product ' + Cast ( @ProdRand as nvarchar(15)))
				Print @IDA
				Set @IdA= @IdA+1
			End

	End

IF (Exists ( Select * from INFORMATION_SCHEMA.TABLES where Table_name='TempA' ))
	Begin
		Print 'Yes, This table is present here now!'
		Select * from TempA
	END
Else
	Begin
		Print 'The desired table is not present here!'
	END
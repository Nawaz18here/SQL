--1. Generate random number using RAND() Function & while loop

declare @Upper int, @Lower int, @Id int, @rand int
Select @Upper=100, @Lower=2, @id=1

--select ROUND ( (( @Upper-@Lower) * Rand() + 1), 0 )

while (@id< 100)
Begin
	Select @Rand = ROUND ( (( @Upper-@Lower) * Rand() + 1), 0 )
	Print @rand
	Set @Id= @id+1

	If (@Rand=14)
	Begin
		Print 'Number ' + Cast ( @Rand as nvarchar(4)) + ' Found, So we stopped this loop!!!'
		Break
	End
End 

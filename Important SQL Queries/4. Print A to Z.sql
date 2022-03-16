--4. Print A to Z
-- For a to z [ USE ---> @Start= ASCII('a') ]
Declare @Start int,@End int

Select @Start= ASCII('A'), @End= @Start+26

While (@Start<@End)
Begin
	Print CHAR(@Start)
	Set @Start=@Start+1
End
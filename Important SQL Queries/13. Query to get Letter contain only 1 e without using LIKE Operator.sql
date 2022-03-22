-- Query to get "Letter contain only 1 e" without using LIKE Operator


Declare @Name varchar(50)
Set @Name='Ramsh'
If (Len(@Name)- Len(Replace(@Name,'e',''))=1)
	BEGIN
		Select ('Yes')
	END
ELSE
	BEGIN
		Select ('No')
	END

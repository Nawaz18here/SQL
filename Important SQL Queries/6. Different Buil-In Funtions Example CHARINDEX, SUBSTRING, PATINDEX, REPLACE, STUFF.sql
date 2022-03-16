--6. Different Buil-In Funtions Example: CHARINDEX, SUBSTRING, PATINDEX, REPLACE, STUFF

Declare @Email nvarchar(50)
Set @Email='john@aaa.com'

--CHARINDEX
SELECT CHARINDEX('@', @Email, 1 ) AS [INDEX]

--SUBSTRING---> aaa.com
SELECT SUBSTRING(@Email, (CHARINDEX('@', @Email, 1 )+1) ,LEN(@Email)-CHARINDEX('@',@Email,1) ) as [SUBSTRING]

--REPLICATE----> jo*****@aaa.com
SELECT SUBSTRING(@Email,1,2)+ REPLICATE('*',5)+SUBSTRING(@Email, (CHARINDEX('@', @Email, 1 )+1) , LEN(@Email)-CHARINDEX('@',@Email,1) ) as [REPLICATE]

--PATINDEX 
Select PATINDEX('%@aaa.com',@Email) as FirstOccurence

--REPLACE
Select REPLACE(@Email,'@aaa.com','@net.co.in') as REPLACED

--STUFF----> jo*******@aaa.com ( 7 Star In between )

SELECT STUFF(@Email,3,2,'*******') as Stuffed
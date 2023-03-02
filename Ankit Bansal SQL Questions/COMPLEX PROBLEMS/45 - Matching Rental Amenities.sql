
-- 45 - Matching Rental Amenities

--create table rental_amenities(
--rental_id int,
--amenities varchar(50)
--);
--delete from rental_amenities;
--insert into rental_amenities values 
--(123,'Pool')
--,(123,'Kitchen')
--,(234,'Hot Tub')
--,(234,'Fire Place')
--,(345,'Kitchen')
--,(345,'Pool')
--,(456,'Pool')
--,(789,'Pet')
--,(789,'Friendly')
--,(765,'Fire Place')
--,(891,'Fire Place')
--,(761,'Fire Place')
--,(451,'Pet')
--,(451,'Friendly')
--,(881,'Beach')
--,(881,'Free Parking')

------------------------------------------------------------

Select * from rental_amenities

------------------------------------------------------------

--USING string_agg and COUNT FUNCTION

go
with cte_amenities as (
	Select rental_id,
	string_agg(amenities,'-')
	within group (order by amenities) as Group_amenities
	from rental_amenities
	group by rental_id
)
Select *--count(1) as Count_
from cte_amenities c1
inner join cte_amenities c2
on c1.Group_amenities = c2.Group_amenities
and c1.rental_id < c2.rental_id

------------------------------------------------------------

-- USING sqlFactorial Function and String_Agg in SQL SERVER 

--create function sqlFactorial(@number int)
--returns int
--as begin
--Declare @i int = 1,@result int=1
--while (@i<=@number)
--Begin
--	Set @result = @result * @i
--	Set @i += 1
--End
--return @result
--End

--select
-- dbo.sqlFactorial(0) [0 factorial],
-- dbo.sqlFactorial(1) [1 factorial],
-- dbo.sqlFactorial(5) [5 factorial],
-- dbo.sqlFactorial(6) [6 factorial]



go
with cte_amenities as (
		Select rental_id,
		string_agg(amenities,'-')
		within group (order by amenities) as Group_amenities
		from rental_amenities
		group by rental_id
	)
,cte2 as (
	Select Group_amenities,count(1) as cnt
	from cte_amenities 
	group by Group_amenities
	having count(1) > 1
	)
Select -- Group_amenities,dbo.sqlFactorial(cnt)/ ( dbo.sqlFactorial(cnt-2) * dbo.sqlFactorial(2) )
SUM(dbo.sqlFactorial(cnt)/ ( dbo.sqlFactorial(cnt-2) * dbo.sqlFactorial(2) ) )
as matching_airbnb
from cte2


------------------------------------------------------------





--39. Write a SQL query to print movie theater like seating numbers as shown in the video

With CTE1 as (
select CHAR(ASCII('A')) as letter
UNION ALL
Select CHAR( ASCII(letter) + 1 ) as letter from CTE1 where letter<'L'
),
CTE2 as (
Select 1 as Num
UNION ALL
Select Num+1 as Num from CTE2 where Num<=10
), 
CTE_final as (
Select letter as letter, letter + Trim(STR(num)) as Seat from CTE1 cross join CTE2 
)
Select Letter, STRING_AGG(Seat, ' ,' ) as Seat_number
from CTE_final
group by letter

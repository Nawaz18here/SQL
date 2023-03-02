
-- 4- Query to provode the date for nth occurence
-- of Sunday in future from given date

--datepart
--sunday-1
--Monday-2
--Tuesday-3
--Wednesday-4
--Thu-5
--Fri-6
--Sat-7

declare @today_date date
declare @n int
set @n = 3
set @today_date = '2022-01-01'

select datename(WEEKDAY,@today_date)
Select datepart(weekday,@today_date)

select 
dateadd(week,@n-1,
dateadd(day,8- datepart(weekday,@today_date),@today_date
))

2022-01-01---Saturday
2022-01-02---1st Sunday
2022-01-16---2nd Sunday
2022-01-23---3rd Sunday


------------------------------------------------------------

-- 26- Horizontal Sorting in SQL- Total No of message excahnged btween each person
--| Amazon Interview Question for BIE position


--CREATE TABLE subscriber (
-- sms_date date ,
-- sender varchar(20) ,
-- receiver varchar(20) ,
-- sms_no int
--);
---- insert some values
--INSERT INTO subscriber VALUES ('2020-4-1', 'Avinash', 'Vibhor',10);
--INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Avinash',20);
--INSERT INTO subscriber VALUES ('2020-4-1', 'Avinash', 'Pawan',30);
--INSERT INTO subscriber VALUES ('2020-4-1', 'Pawan', 'Avinash',20);
--INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Pawan',5);
--INSERT INTO subscriber VALUES ('2020-4-1', 'Pawan', 'Vibhor',8);
--INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Deepak',50);

--------------------------------------------------------------

--select * from subscriber

--USING CASE WHEN 

go
with cte as 
(
	select * , case when sender < receiver then sender else receiver end as sender_person
	, case when sender > receiver then sender else receiver end as receiver_person
	from subscriber
)
select sms_date,sender_person,receiver_person,sum(sms_no) as sms_total
from cte 
group by sms_date,sender_person,receiver_person

--------------------------------------------------------------

--USING LEFT JOIN

go
WITH CTE AS
(
	SELECT S1.*,S2.sms_no AS sms_to_sender,COALESCE((S2.sms_no+S1.sms_no),S1.sms_no) AS total_messages 
	FROM subscriber S1
	LEFT JOIN subscriber S2
	ON S1.sender=S2.receiver AND S1.receiver=S2.sender
)
SELECT sms_date,sender,receiver,total_messages
FROM CTE
WHERE sender<receiver OR sms_to_sender IS NULL

--------------------------------------------------------------

-- CASE WHEN and concat 

WITH CTE AS (
SELECT *, (CASE WHEN sender < receiver THEN CONCAT(sender,' ',receiver) ELSE CONCAT(receiver,' ',sender) END) AS couple 
FROM subscriber 
)
SELECT sms_date, min(sender) as Person1,max(receiver) as Person2,
SUM(sms_no) as sms_count
FROM CTE
GROUP BY sms_date,couple

--------------------------------------------------------------



--44- SQL Problem Based on Bank Transactions Asked in Visa Interview

/*
Table Script for the problem:
*/

--CREATE TABLE BalanceTbl (
--    transaction_id INT PRIMARY KEY,
--    type VARCHAR(20),
--    amount DECIMAL(10, 2),
--    transaction_date DATE
--);

--INSERT INTO BalanceTbl (transaction_id, type, amount, transaction_date)
--VALUES
--  (1, 'deposit', 100.00, '2022-01-01'),
--  (2, 'withdrawal', 50.00, '2022-01-01'),
--  (3, 'deposit', 75.00, '2022-01-06'),
--  (4, 'withdrawal', 20.00, '2022-01-10'),
--  (5, 'deposit', 200.00, '2022-01-10'),
--  (6, 'withdrawal', 30.00, '2022-02-02'),
--  (7, 'deposit', 150.00, '2022-02-05'),
--  (8, 'withdrawal', 60.00, '2022-02-14'),
--  (9, 'deposit', 125.00, '2022-02-14'),
--  (10, 'withdrawal', 25.00, '2022-02-18'),
--  (11, 'deposit', 300.00, '2022-03-01'),
--  (12, 'withdrawal', 40.00, '2022-03-04'),
--  (13, 'deposit', 50.00, '2022-03-04'),
--  (14, 'withdrawal', 80.00, '2022-03-04'),
--  (15, 'deposit', 175.00, '2022-03-15');

--------------------------------------------------------------

Select * from BalanceTbl

--------------------------------------------------------------

--My Approach USING SUM and CTE 


go
with balance_cte as (
	Select transaction_date
	,sum(case when type = 'deposit' then amount 
	when type = 'withdrawal' then -1*amount end)
	as total_day_amount
	from BalanceTbl
	group by transaction_date
	)
select transaction_date, total_day_amount,sum(total_day_amount)
over(partition by month(transaction_date)
order by transaction_date)
as cummulative_sum_total
from balance_cte



--------------------------------------------------------------

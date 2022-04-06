--16. How to Prime Number between 1 to 10 in SQL

With CTE as 
(
Select 2 as Primenmbr
Union All
Select A.Primenmbr+1 from CTE A
where A.Primenmbr<10
)
Select * from CTE A
where NOT EXISTS  (
					Select 1 from CTE B
					where A.Primenmbr % B.Primenmbr=0
					AND A.Primenmbr!=B.Primenmbr
					)
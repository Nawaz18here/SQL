
-- 13- Recommendation System - Complex SQL 13

--create table ordersD
--(
--order_id int,
--customer_id int,
--product_id int,
--);

--insert into ordersD VALUES 
--(1, 1, 1),
--(1, 1, 2),
--(1, 1, 3),
--(2, 2, 1),
--(2, 2, 2),
--(2, 2, 4),
--(3, 1, 5);

--create table products (
--id int,
--name varchar(10)
--);
--delete from products

--insert into products VALUES 
--(1, 'A'),
--(2, 'B'),
--(3, 'C'),
--(4, 'D'),
--(5, 'E');

------------------------------------------------------------

select * from ordersD
select * from ordersD
select * from products

------------------------------------------------------------


go
select 
--o1.order_id , o1.product_id as p1, o2.product_id as p2, 
--pr1.name as pname1, pr2.name as pname2, 
concat(pr1.name,' ',pr2.name ) as pair 
,count(1) as purchase_freq
from ordersD o1
inner join ordersD o2 on o1.order_id = o2.order_id
inner join products pr1 on pr1.id = o1.product_id 
inner join products pr2 on pr2.id = o2.product_id 
where o1.product_id <> o2.product_id and o1.product_id > o2.product_id
group by pr1.name , pr2.name 



------------------------------------------------------------


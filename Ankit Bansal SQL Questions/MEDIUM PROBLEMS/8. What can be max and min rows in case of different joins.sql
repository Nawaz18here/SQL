-- 8. What can be max and min rows in case of different joins

--create table t1 ( id int )
--insert into t1 values(1),(1),(1),(1),(1)

--create table t2 ( id int )
--insert into t2 values(1),(1),(1),(1),(1),(1),(1),(1),(1),(1)

--create table t3 ( id int )
--insert into t3 values(2),(2),(2),(2),(2),(2),(2),(2),(2),(2)


--DROP TABLE t1
--DROP TABLE t2

Select * from t1
Select * from t2

Select * from t1 inner join t2 on t1.id=t2.id
--Inner Join
--max= 50
--min= 0

Select * from t1 left join t2 on t1.id=t2.id
--Left Join
--max= 50
--min= 5

Select * from t1 right join t2 on t1.id=t2.id
--Right Join
--max= 50
--min= 10

Select * from t1 full join t2 on t1.id=t2.id
--Full Join
--max= 50
--min= 15

--FOR MINIMUM

Select * from t1 inner join t3 on t1.id=t3.id

Select * from t1 left join t3 on t1.id=t3.id

Select * from t1 right join t3 on t1.id=t3.id

Select * from t1 full join t3 on t1.id=t3.id

------------------------------------------------------------

--create table c1 ( id int )
--insert into c1 values(1),(2),(3)

--create table c2 ( id int )
--insert into c2 values(4),(5),(6),(7),(8)

--DROP TABLE C1
--DROP TABLE C2

--Delete from c1
--Delete from c2

Select * from c1
Select * from c2

Select * from c1 inner join c2 on c1.id=c2.id

Select * from c1 left join c2 on c1.id=c2.id

Select * from c1 right join c2 on c1.id=c2.id

Select * from c1 full join c2 on c1.id=c2.id


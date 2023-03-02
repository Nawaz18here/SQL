
-- 13- Summation of postive no and negative no 

/*
create table x ( a int )
insert into x values (2),(5),(4),(56),(-1),(-5),(-4)
*/

SELECT * FROM X

select 
sum(case when a>0 then a else 0 end) sum_pos_no,
sum(case when a<0 then a else 0 end) sum_neg_no,
sum(a) as sum_all_no
from x



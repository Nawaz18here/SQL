--23. Write SQL to get unique combination of  two columns Source and Destination irrespective of order of columns

--Create Table Travel_Table(
--Start_Location Varchar(30),
--End_Location Varchar(30),
--Distance int)
--Insert into Travel_Table Values('Delhi','Pune',1400);
--Insert into Travel_Table Values('Pune','Delhi',1400);
--Insert into Travel_Table Values('Bangalore','Chennai',350);
--Insert into Travel_Table Values('Mumbai','Ahmedabad',500);
--Insert into Travel_Table Values('Chennai','Bangalore',350);
--Insert into Travel_Table Values('Patna','Ranchi',300);

Select * from Travel_Table

Select MAX(SOURCE) as Source, MIN(SOURCE) as Dest, Distance from 
(Select DISTINCT Start_Location as SOURCE, Distance
from Travel_Table 
UNION
Select DISTINCT End_Location as DESTINATION, Distance
from Travel_Table) s group by Distance


select distinct
case when start_location>end_location then start_location else end_location end "start_location",
case when start_location>end_location then end_location else start_location end "end_location",distance
from Travel_Table order by Distance

-- DROP TABLE Travel_Table
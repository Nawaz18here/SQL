--19. SQL to turn the columns English, Maths and Science into rows. It should display Marks for each student for each subjects as shown below

--Create Table studentinfo(
--studentname Varchar(20),
--english int,
--maths int,
--science int);
--insert into studentinfo values ('David',85,90,88);
--insert into studentinfo values ('John',75,85,80);
--insert into studentinfo values ('Tom',83,80,92);


--USING UNPIVOT OPERATOR

Select studentname, subject,marks from (
Select studentname,English,maths,science from Studentinfo ) a
UNPIVOT 
(
	Marks
	For Subject in ([English],[Maths],[Science]) 
) as B


Select * from Studentinfo

Select StudentName, 'English' as Subject, English as Marks from Studentinfo
UNION ALL
Select StudentName, 'Maths' as Subject, Maths as Marks from Studentinfo
UNION ALL
Select StudentName, 'Science' as Subject, Science as Marks from Studentinfo


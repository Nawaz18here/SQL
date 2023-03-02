
-- 6- To get PersonId, Name, Friends_Count & Total_Friends_Score

Select * from Person
Select * from Friend

Select Pr.name,a.*
from 
	(
		Select F.PersonID,Count(F.FriendID) as Friends_Count  , SUM(P.score) as Total_Friends_Score
		from Person P
		inner join Friend F
		on P.PersonId = F.FriendId
		group by F.PersonID
		Having SUM(P.score) >=100
	) a 
inner join person pr
on a.personid = pr.personid

------------------------------------------------------------

Select F.*,P.*
from Person P
inner join Friend F
on P.PersonId = F.FriendId


 
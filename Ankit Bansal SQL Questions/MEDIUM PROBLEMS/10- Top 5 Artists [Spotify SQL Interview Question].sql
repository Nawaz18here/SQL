
---- 10- Top 5 Artists [Spotify SQL Interview Question]

--create table artists
--( artist_id int,
--artist_name varchar(50)
--)

--insert into artists 
--values(101,'Ed Sheeran'),
--(120,'Drake')

------------------------------

--create table songs
--( song_id int,
--artist_id int
--)

--insert into songs 
--values(45202,101),(19960,120)
------------------------------

--create table global_song_rank
--( day int,
--song_id int,
--rank int
--)

--insert into global_song_rank 
--values
--(1,45202,5),
--(3,45202,2),
--(1,19960,3),
--(9,19960,15)

----Drop table artists
----Drop table songs
----Drop table global_song_rank


Select * from artists
Select * from songs
Select * from global_song_rank

------------------------------------------------------------

--USING CTE AND WINDOW FUNCTION

With CTE as 
	(
		Select song_id, Count([rank]) 'song_appearances'
		from global_song_rank
		where [rank]<=10
		group by song_id
	),
CTE2 as 
	(
		Select artist_name,DENSE_RANK() Over(Order by song_appearances desc )
		as Artist_rank
		from CTE c inner join songs s
		on c.song_id = s.song_id
		inner join artists a
		on a.artist_id = s.artist_id 
	)
Select * from CTE2 
where artist_rank<=5


------------------------------------------------------------
--USING SUBUERY 

Select ar.artist_name,rnk 
	from (
		Select *,dense_rank() Over(Order by Song_Appearance desc ) as rnk 
		from
			(
				Select s.artist_id,Count(1) as 'Song_Appearance'
				from global_song_rank g 
				inner join songs s
				on g.song_id=s.song_id
				where [rank]<=10
				group by artist_id
			) a 
		) b 
	inner join artists ar
	on b.artist_id = ar.artist_id
	where rnk<=5




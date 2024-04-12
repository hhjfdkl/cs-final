select * from movie_to_genre;

select * from genres;

select m.movie_id, m.titletext, g.genre_name 
from movies AS m 
RIGHT JOIN movie_to_genre AS mg ON mg.movie_id = m.movie_id
RIGHT JOIN genres AS g ON g.genre_id = mg.genre_id;

select titletext
from movies 
WHERE movie_id = 2;


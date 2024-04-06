-- Projetar o primeiro nome e o último nome dos atores que são diretores;
SELECT actors.first_name, actors.last_name
FROM actors
INTERSECT
SELECT directors.first_name, directors.last_name
FROM directors

-- Projetar o primeiro nome e o último nome dos atores que não são diretores;
SELECT actors.first_name, actors.last_name
FROM actors
EXCEPT
SELECT directors.first_name, directors.last_name
FROM directors

-- Projetar o primeiro nome e o último nome dos atores e diretores;
SELECT actors.first_name, actors.last_name
FROM actors
UNION
SELECT directors.first_name, directors.last_name
FROM directors

-- Projetar o nome dos filmes que não são dirigidos por nenhum diretor;
SELECT movies.name
FROM 
	movies 
	JOIN (
        SELECT movies.id
		FROM movies
		EXCEPT
		SELECT movies_directors.movie_id
		FROM movies_directors
        ) AS A
	ON movies.id = A.id

-- Projetar primeiro nome e o último nome dos atores que não atuaram em pelo menos dois filmes;
SELECT actors.first_name, actors.last_name 
FROM 
    actors 
	JOIN (
		SELECT actors.id 
		FROM actors
		EXCEPT
		SELECT A.actor_id
		FROM (
			SELECT roles.actor_id, COUNT(*) AS total
			FROM roles
			GROUP BY roles.actor_id
			HAVING total > 1
			) AS A
		) AS B 
	ON actors.id = B.id

-- Projetar, por gênero e ano, o número médio de filmes com menos de dois atores atuando.
SELECT movies_genres.genre, movies.year, COUNT(*) AS num_movies
FROM 
	movies_genres 
	JOIN  movies ON movies_genres.movie_id = movies.id
	JOIN (
		SELECT movies.id 
		FROM movies
		EXCEPT
		SELECT A.movie_id
		FROM (
			SELECT roles.movie_id, COUNT(*) AS total
			FROM roles
			GROUP BY roles.movie_id
			HAVING total > 1
			) AS A
		) AS B 
	ON movies.id = B.id
GROUP BY movies_genres.genre,movies.year
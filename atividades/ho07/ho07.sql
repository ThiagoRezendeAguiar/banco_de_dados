-- Projetar o primeiro nome e o último nome dos atores de sexo feminino;
SELECT first_name, last_name 
FROM actors 
WHERE gender = 'F'

-- Projetar o nome dos filmes com ano superior à 1999;
SELECT name 
FROM movies 
WHERE year > 1999

-- Projetar o nome do filme e o nome do diretor de cada filme;
SELECT movies.name, directors.first_name, directors.last_name 
FROM 
    movies 
    JOIN movies_directors ON movies.id = movies_directors.movie_id 
    JOIN directors ON directors.id = movies_directors.director_id

-- Projetar o nome do filme, nome do ator e o papel que cada ator teve no filme para filmes com ranking acima da nota 6;
SELECT movies.name, actors.first_name, actors.last_name, roles.role 
FROM 
	movies 
	JOIN roles ON movies.id = roles.movie_id 
	JOIN actors ON actors.id = roles.actor_id
WHERE movies.rank > 6

-- Projetar o nome do diretor e o número de filmes que cada diretor dirigiu;
SELECT directors.first_name, directors.last_name, COUNT(*) AS num_movies
FROM 
	directors
	JOIN movies_directors ON directors.id = movies_directors.director_id 
GROUP BY directors.first_name, directors.last_name

-- Projetar o gênero e o número de filmes de cada gênero;
SELECT movies_genres.genre, COUNT(*) AS num_movies
FROM movies_genres
GROUP BY movies_genres.genre

-- Projetar o gênero, o ranking (nota) médio, mínimo e máximo dos filmes do gênero.
SELECT movies_genres.genre, AVG(movies.rank) AS avg_rank, MIN(movies.rank) AS min_rank, MAX(movies.rank) AS max_rank
FROM 
    movies_genres
	JOIN movies ON movies_genres.movie_id = movies.id
GROUP BY movies_genres.genre


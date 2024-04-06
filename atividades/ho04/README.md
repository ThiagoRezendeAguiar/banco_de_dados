# Álgebra Relacional

Especificar as seguintes consultas em álgebra relacional para recuperar os dados em um banco de dados relacional, considerando o conjunto de dados (dataset) denominado IMDB-sample disponível na calculadora [RelaX](https://dbis-uibk.github.io/relax/calc/gist/41cf5ce652756d9331eec7562644e074/imdbsample/0) to an external site.:

1. Projetar o primeiro nome e o último nome dos atores de sexo feminino;
2. Projetar o nome dos filmes com ano superior à 1999;
3. Projetar o nome do filme e o nome do diretor de cada filme;
4. Projetar o nome do filme, nome do ator e o papel que cada ator teve no filme para filmes com ranking acima da nota 6;
5. Projetar o nome do diretor e o número de filmes que cada diretor dirigiu;
6. Projetar o gênero e o número de filmes de cada gênero;
7. Projetar o gênero, o ranking (nota) médio, mínimo e máximo dos filmes do gênero.

## Respostas

1. A ← σ gender = 'F' ( actors ) <br/>
   π first_name, last_name ( A )

2. A ← σ year > 1999 ( movies ) <br/>
   π name ( A )

3. A ← directors ⨝ id = director_id ( movies_directors ) <br/>
   B ← ρ id_m ← id ( movies ) <br/>
   C ← B ⨝ id_m = movie_id ( A ) <br/>
   π name, first_name, last_name ( C )

4. A ← σ rank > 6 ( movies ) <br/>
   B ← A ⨝ id = movie_id ( roles ) <br/>
   C ← ρ id_a ← id( actors ) <br/>
   D ← B ⨝ actor_id = id_a ( C ) <br/>
   π name, first_name, last_name, role ( D )

5. A ← director_id γ COUNT( movie_id ) → num_movies ( movies_directors ) <br/>
   B ← A ⨝ director_id = id ( directors ) <br/>
   π first_name, last_name, num_movies ( B )

6. A ← genre γ COUNT(movie_id) → num_movies ( movies_genres) <br/>
   π genre, num_movies (A)

7. A ← movies ⨝ id = movie_id ( movies_genres ) <br/>
   B ← genre γ AVG( rank ) → ranking_avg, MIN( rank ) → ranking_min, MAX( rank ) → ranking_max ( A ) <br/>
   π genre, ranking_avg, ranking_min, ranking_max ( B )

# Álgebra Relacional II

Especificar as seguintes consultas em álgebra relacional para recuperar os dados em um banco de dados relacional, considerando o conjunto de dados (dataset) denominado IMDB-sample disponível na calculadora [RelaX](https://dbis-uibk.github.io/relax/calc/gist/41cf5ce652756d9331eec7562644e074/imdbsample/0):

1. Projetar o primeiro nome e o último nome dos atores que são diretores;
2. Projetar o primeiro nome e o último nome dos atores que não são diretores;
3. Projetar o primeiro nome e o último nome dos atores e diretores;
4. Projetar o nome dos filmes que não são dirigidos por nenhum diretor;
5. Projetar primeiro nome e o último nome dos atores que não atuaram em pelo menos dois filmes;
6. Projetar, por gênero e ano, o número médio de filmes com menos de dois atores atuando.

## Respostas

1. A ← π first_name, last_name ( actors ) <br/>
   B ← π first_name, last_name ( directors ) <br/>
   A ∩ B

2. A ← π first_name, last_name ( actors ) <br/>
   B ← π first_name, last_name ( directors ) <br/>
   A - B

3. A ← π first_name, last_name ( actors ) <br/>
   B ← π first_name, last_name ( directors ) <br/>
   A ∪ B

4. A ← π id ( movies ) <br/>
   B ← π movie_id ( movies_directors ) <br/>
   C ← ρ mov_id ← id ( A - B ) <br/>
   D ← C ⨝ mov_id = id ( movies ) <br/>
   π name ( D )

5. A ← actor_id γ COUNT( movie_id ) → num_movies ( roles ) <br/>
   B ← σ num_movies ≥ 2 ( A ) <br/>
   C ← π id ( actors ) <br/>
   D ← π actor_id ( B ) <br/>
   E ← ρ id_a ← id ( C - D ) <br/>
   F ← actors ⨝ id = id_a ( E ) <br/>
   π first_name, last_name ( F )

6. A ← γ movie_id; COUNT( actor_id ) → num_actors ( roles ) <br/>
   B ← σ num_actors ≥ 2 ( A ) <br/>
   C ← π id ( movies ) <br/>
   D ← π movie_id ( B ) <br/>
   E ← ρ id_m ← id ( C - D ) <br/>
   F ← movies ⨝ id = id_m ( E ) <br/>
   G ← F ⨝ id = movie_id ( movies_genres ) <br/>
   H ← genre, year γ COUNT( id ) → num_movies ( G ) <br/>
   π genre, year, num_movies ( H )

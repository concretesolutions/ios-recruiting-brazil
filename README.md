# Concrete iOS Recruit Challenge


![Gif](assets/Logo-animado-1.gif)



### Sobre o aplicativo

App criado com as funcionalidades de apresentação dos filmes populares disponiveis na API do TheMovieDB podendo adicionar favoritos com persistencia local e fazer filtros sobre os mesmos, foi utilizada a arquitetura MVVM para o desenvolvimento.

![Image of Yaktocat](assets/flow/grid.png)
![Image of Yaktocat](assets/flow/detail.png)
![Image of Yaktocat](assets/flow/favorite.png)
![Image of Yaktocat](assets/flow/filter.png)


# Features ..

---

### Precisa ter:

- Tela de Splash;
- Layout em abas, contendo na primeira aba a tela de grid de filmes e na segunda aba a tela de lista de filmes favoritados no app;
- Tela de grid de filmes trazendo a lista de filmes populares da [API](https://developers.themoviedb.org/3/movies/get-popular-movies).
- Tratamento de erros e apresentação dos fluxos de exceção: Busca vazia, Error generico, loading;
- Ao clicar em um filme do grid deve navegar para a tela de detalhe do filme;
- Tela de Detalhe do filme deve conter ação para favoritar o filme;
- Tela de Detalhe do filme deve conter gênero do filme por extenso (ex: Action, Horror, etc); Use esse [request](https://developers.themoviedb.org/3/genres/get-movie-list) da API para trazer a lista.
- Tela de lista de favoritos persistido no app entre sessões;
- Tela de favoritos deve permitir desfavoritar um filme.

### Ganha mais pontos se tiver:

- Tela de grid com busca local;
- Scroll Infinito para fazer paginação da API de filmes populares;
- Célula do Grid de filmes com informação se o filme foi favoritado no app ou não;
- Tela de filtro com seleção de data de lançamento e gênero. A tela de filtro só é acessível a partir da tela de favoritos;
- Ao Aplicar o filtro, retornar a tela de favoritos e fazer um filtro local usando as informações selecionadas referentes a data de lançamento e gênero;
- Testes unitários no projeto;
- Testes funcionais.
- Pipeline Automatizado


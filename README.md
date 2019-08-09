# Concrete iOS Recruit Challenge

---

![Gif](assets/Logo-animado-1.gif)


# Movs

Movs é um aplicativo que trás informações dos filmes mais populares direto do The Movie DB. 

## Features

Com esse app é possível navegar por uma lista de filmes frequentemente atualizada, assim como pesquisar o que deseja, ver informações detalhadas e escolher seus filmes favoritos.

## Outros detalhes

Esse app é resultado do desafio proposto pela Concrete Solutions, como parte de um processo seletivo. A arquitetura escolhida para desenvolver o projeto foi o modelo VIPER e funções de persistência foram criadas a partir do Core Data. Dentre as features designadas no desafio, as seguintes foram feitas:

- Tela de Splash;
- Layout em abas, contendo na primeira aba a tela de grid de filmes e na segunda aba a tela de lista de filmes favoritados no app;
- Tela de grid de filmes trazendo a lista de filmes populares da API.
- Tratamento de erros e apresentação dos fluxos de exceção: Busca vazia, Error generico, loading;
- Ao clicar em um filme do grid deve navegar para a tela de detalhe do filme;
- Tela de Detalhe do filme deve conter ação para favoritar o filme;
- Tela de Detalhe do filme deve conter gênero do filme por extenso (ex: Action, Horror, etc); Use esse request da API para trazer a lista.
- Tela de lista de favoritos persistido no app entre sessões;
- Tela de favoritos deve permitir desfavoritar um filme.
- Tela de grid com busca local;
- Scroll Infinito para fazer paginação da API de filmes populares;
- Célula do Grid de filmes com informação se o filme foi favoritado no app ou não;
- Tela de filtro com seleção de data de lançamento e gênero. A tela de filtro só é acessível a partir da tela de favoritos;
- Ao Aplicar o filtro, retornar a tela de favoritos e fazer um filtro local usando as informações selecionadas referentes a data de lançamento e gênero;
- Testes unitários no projeto;
- Testes funcionais.
- Pipeline Automatizado (com alguns problemas relacionados provavelmente a versão do xcode)

## Frameworks externas e APIs utilizadas

- RxCocoa
- RxSwift
- Quick
- Nimble
- Nimble-Snapshots
- The Movie DB

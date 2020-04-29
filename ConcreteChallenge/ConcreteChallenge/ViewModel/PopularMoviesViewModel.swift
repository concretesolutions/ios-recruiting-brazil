//
//  PopularMoviesViewModel.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 18/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

struct PopularMoviesViewModel: Equatable {
    let genres: [Genre]
    let movies: [Movie]
    let page: Int
    let totalPages: Int
    let filters: MovieFilters
    let isSearching: Bool
    let isLastPage: Bool
    let loading: Bool
    let requestError: String
    let isConnected: Bool
    var loadingFooterState: LoadingFooterState = .hidden
    
    var backgroundViewConfiguration: BackgroundStateViewModel?
    
    init(state: RootState) {
        genres = state.genre.genres
        page = state.movie.page
        totalPages = state.movie.totalPages
        
        filters = state.movie.filters
        
        isLastPage = totalPages == page
        
        isSearching = state.movie.isSearching
        
        let isLoading = state.genre.loading || state.movie.loading
        
        let isRefreshing = page == 1 && state.movie.loading && !state.movie.isSearching
        
        if isRefreshing {
            movies = []
        } else {
            movies = state.movie.movies
        }
        
        requestError = state.movie.errorMessage
        
        isConnected = state.infra.isConnected
        
        // Background State
        if !requestError.isEmpty {
            backgroundViewConfiguration = BackgroundStateViewModel(
                title: "Ocoreu um erro",
                subtitle: "Não conseguimos comunicar com o servidor. Tente novamente mais tarde.",
                image: BackgroundStateViewImages.error,
                retry: "Tentar novamente"
            )
        } else if !isConnected {
             backgroundViewConfiguration = BackgroundStateViewModel(
                 title: "Sem conexão",
                 subtitle: "Parece que você não está conectado a internet. Conecte-se para tentar novamente.",
                 image: BackgroundStateViewImages.connection,
                 retry: "Tentar novamente"
             )
        } else if movies.count < 1 && !isLoading {
            if isSearching {
                backgroundViewConfiguration = BackgroundStateViewModel(
                    title: "Não encontramos nada!",
                    subtitle: "Considerem reduzir o número de filtros para obter mais resultados e tente novamente.",
                    image: .search,
                    retry: ""
                )
            } else {
                 backgroundViewConfiguration = BackgroundStateViewModel(
                     title: "Não encontramos nada!",
                     subtitle: "Considerem reduzir o número de filtros para obter mais resultados e tente novamente.",
                     image: .movie,
                     retry: "Tentar novamente"
                 )
            }
        } else {
            backgroundViewConfiguration = nil
        }
        
        self.loading = isLoading
        
        // Footer State
        if isLoading {
            if state.movie.isPaginating {
                loadingFooterState = .loading
            } else {
                loadingFooterState = .hidden
            }
        } else if self.isLastPage {
            loadingFooterState = .thatsAll
        } else {
            loadingFooterState = .hidden
        }
    }
}


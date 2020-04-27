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
    let loading: Bool
    let requestError: String
    let isConnected: Bool
    var backgroundViewConfiguration: BackgroundStateViewModel?
    
    init(state: RootState) {
        genres = state.genre.genres
        movies = state.movie.movies
        
        loading = state.genre.loading || state.movie.loading
        requestError = state.movie.errorMessage
        
        isConnected = state.infra.isConnected
        
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
        } else if movies.count < 1 && !loading {
             backgroundViewConfiguration = BackgroundStateViewModel(
                 title: "Não encontramos nada!",
                 subtitle: "Considerem reduzir o número de filtros para obter mais resultados e tente novamente.",
                 image: BackgroundStateViewImages.search,
                 retry: "Tentar novamente"
             )
        } else {
            backgroundViewConfiguration = nil
        }
        
        
    }
}


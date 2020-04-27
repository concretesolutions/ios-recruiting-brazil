//
//  FavoritesViewModel.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 24/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

struct FavoritesViewModel: Equatable {
    let favorites: [Favorite]
    let requestError: String
    let isConnected: Bool
    let isSearching: Bool
    var backgroundViewConfiguration: BackgroundStateViewModel?
    
    init(state: RootState) {
        favorites = state.favorites.favorites
        requestError = state.favorites.latestError
        
        isConnected = state.infra.isConnected
        
        isSearching = false
        
        if !requestError.isEmpty {
            backgroundViewConfiguration = BackgroundStateViewModel(
                title: "Ocoreu um erro",
                subtitle: "Não conseguimos comunicar com o servidor. Tente novamente mais tarde.",
                image: .error,
                retry: "Tentar novamente"
            )
        } else if !isConnected {
             backgroundViewConfiguration = BackgroundStateViewModel(
                 title: "Sem conexão",
                 subtitle: "Parece que você não está conectado a internet. Conecte-se para tentar novamente.",
                 image: .connection,
                 retry: "Tentar novamente"
             )
        } else if favorites.count < 1 {
            if isSearching {
                 backgroundViewConfiguration = BackgroundStateViewModel(
                     title: "Não encontramos nada!",
                     subtitle: "Considerem reduzir o número de filtros para obter mais resultados e tente novamente.",
                     image: .search,
                     retry: "Tentar novamente"
                 )
            } else {
                backgroundViewConfiguration = BackgroundStateViewModel(
                    title: "Nenhum favorito",
                    subtitle: "Você ainda não adicionou favoritos",
                    image: .movie,
                    retry: ""
                )
            }
        } else {
            backgroundViewConfiguration = nil
        }
        
    }
}

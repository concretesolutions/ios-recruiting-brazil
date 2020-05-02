//
//  FavoritesViewModel.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 24/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import Foundation

struct FavoritesViewModel {
    let favorites: [Favorite]
    let genres: [Genre]
    let filters: FavoriteFilters

    var genresOptions: [String] = ["Todos"]
    var yearsOptions: [String] = ["Qualquer ano"]

    let requestError: String
    let isConnected: Bool
    let isSearching: Bool
    var backgroundViewConfiguration: BackgroundStateViewModel?

    init(state: RootState) {
        genres = state.genre.genres
        requestError = state.favorites.latestError
        isConnected = state.infra.isConnected
        filters = state.favorites.filters
        self.isSearching = !filters.isEmpty

        if self.isSearching {
            favorites = state.favorites.searchResults
        } else {
            favorites = state.favorites.favorites
        }

        genresOptions += state.genre.genres.map({ $0.name})

        yearsOptions += Array(0...200).map({ "\(Date.currentYear - $0)" })

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
                     retry: ""
                 )
            } else {
                backgroundViewConfiguration = BackgroundStateViewModel(
                    title: "Nenhum favorito",
                    subtitle: "Você ainda não adicionou favoritos",
                    image: .movie,
                    retry: "Tentar novamente"
                )
            }
        } else {
            backgroundViewConfiguration = nil
        }

    }
}

extension FavoritesViewModel: Equatable {
    static func == (lhs: FavoritesViewModel, rhs: FavoritesViewModel) -> Bool {
        return lhs.favorites == rhs.favorites
            && lhs.genres == rhs.genres
            && lhs.filters == rhs.filters
            && lhs.isSearching == rhs.isSearching
            && lhs.backgroundViewConfiguration == rhs.backgroundViewConfiguration
            && lhs.requestError == rhs.requestError
    }
}

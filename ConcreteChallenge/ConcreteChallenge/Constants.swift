//
//  Constants.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 15/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import Foundation

struct Images {
    static let error = "error"
    static let search = "search"
    static let twoHearts = "twoHearts"
    static let listHollow = "listHollow"
    static let listFilled = "listFilled"
    static let heartHollow = "heartHollow"
    static let heartFilled = "heartFilled"
}

struct Cells {
    static let movie = "movieCell"
    static let loading = "loadingCell"
    static let favorite = "favoriteCell"
}

struct Notifications {
    static let newFavoriteMovie = "NewFavoriteMovie"
}

struct UserDefaultsConstants {
    static let currentPage = "currentPage"
}

struct EmptyStateText {
    static let emptySearch = "Sua busca não retornou nenhum resultado. Tente novamente"
    static let requestError = "Ocorreu um erro. Por favor, tente novamente"
    static let emptyFavorites = "Você não possui nenhum filme como favorito"
}

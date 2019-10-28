//
//  FavoritesListDelegate.swift
//  Movs
//
//  Created by Bruno Barbosa on 28/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import Foundation

protocol FavoritesListDelegate: class {
    func favoritesListUpdated()
    func toggleLoading(_ isLoading: Bool)
    func errorFetchingMovies(error: APIError)
}

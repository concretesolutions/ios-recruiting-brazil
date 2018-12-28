//
//  FavoritesDataPresenter.swift
//  movs
//
//  Created by Bruno Muniz Azevedo Filho on 28/12/18.
//  Copyright © 2018 bmaf. All rights reserved.
//

import Foundation

final class FavoritesDataPresenter {
    // MARK: - Singleton
    static let shared = FavoritesDataPresenter()

    private init() {}
}

// MARK: - Public
extension FavoritesDataPresenter {
    func isFavorite(_ movieId: Int) -> Bool {
        guard let favorites
            = UserDefaults.standard.object(forKey: Constants.LocalStorage.favorites) as? [Int] else {
                return false
        }

        return favorites.contains(movieId)
    }

    func favoritedAction(_ movieId: Int) {
        if var favorites
            = UserDefaults.standard.object(forKey: Constants.LocalStorage.favorites) as? [Int] {

            if favorites.contains(movieId) {
                favorites = favorites.filter { $0 != movieId }
            } else {
                favorites.append(movieId)
            }

            UserDefaults.standard.set(favorites, forKey: Constants.LocalStorage.favorites)
        } else {
			UserDefaults.standard.set([Int](), forKey: Constants.LocalStorage.favorites)
        }

        UserDefaults.standard.synchronize()
    }
}

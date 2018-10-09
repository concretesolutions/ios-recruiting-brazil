//
//  MoviesListClient.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 04/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

class FavoritesMoviesListClient {
    private lazy var userDefault = UserDefaultWrapper()
}

//MARK: - GetFavsMovies methods -
extension FavoritesMoviesListClient {
    func getMovies() -> [MovieDetailModel]? {
        guard let favListData: [Data]? = userDefault.get(with: userDefault.favsListKey) else { return nil }
        let favList = favListData?.compactMap { try? JSONDecoder().decode(MovieDetailModel.self, from: $0) }
        return favList
    }
}

//MARK: - DeleteMovie methods -
extension FavoritesMoviesListClient {
    func deleteMovie(in index: Int) -> Bool {
        guard let _:[Data] = userDefault.deleteItem(in: index, with: userDefault.favsListKey) else { return false }
        return true
    }
}

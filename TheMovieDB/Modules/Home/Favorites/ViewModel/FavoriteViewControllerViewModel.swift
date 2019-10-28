//
//  FavoriteViewControllerViewModel.swift
//  TheMovieDB
//
//  Created by Ranieri Aguiar on 27/10/19.
//  Copyright © 2019 Ranieri Aguiar. All rights reserved.
//

class FavoriteViewControllerViewModel {
    var delegate: FavoriteViewControllerProtocol!
    var dao: SQLiteManager!
    
    init(delegate: FavoriteViewControllerProtocol) {
        self.delegate = delegate
        dao = SQLiteManager()
    }
    
    func selectFavoritedMovies() -> [MovieResponse] {
        return dao.selectFavoritedMovies()
    }
    
    func deleteFavoriteMovie(movie: MovieResponse) {
        dao.deleteFavoritedMovie(movie)
    }
}

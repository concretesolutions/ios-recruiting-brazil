//
//  FavoritesPresenter.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 31/10/18.
//  Copyright (c) 2018 Leonel Menezes. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import RealmSwift

protocol FavoritesPresentationLogic {
    func present(movies: [FavoriteMovie])
}

class FavoritesPresenter: FavoritesPresentationLogic {
    weak var viewController: FavoritesDisplayLogic?
    
    func present(movies: [FavoriteMovie]) {
        let displayedMovies = movies.map { (movie) -> Favorites.ViewModel.movie in
            return Favorites.ViewModel.movie(title: movie.title, overview: movie.overview, releaseYear: movie.releaseDate, imageUrl: movie.imageUrl)
        }
        viewController?.display(movies: displayedMovies)
    }
    
}

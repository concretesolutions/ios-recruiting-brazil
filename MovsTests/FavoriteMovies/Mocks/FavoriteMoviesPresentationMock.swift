//
//  FavoriteMoviesPresentationMock.swift
//  MovsTests
//
//  Created by Bruno Chagas on 05/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation

@testable import Movs

class FavoriteMoviesPresentationMock: FavoriteMoviesPresentation {
    
    var hasCalledViewDidLoad: Bool = false
    var hasCalledDidEnterSearch: Bool = false
    var hasCalledDidSelectMovie: Bool = false
    var hasCalledDidDeleteFavorite: Bool = false
    var hasCalledPressFilter: Bool = false
    
    var view: FavoriteMoviesView?
    var interactor: FavoriteMoviesUseCase!
    var router: FavoriteMoviesWireframe!
    var filteredMovies: [MovieEntity] = []
    
    func viewDidLoad() {
        hasCalledViewDidLoad = true
    }
    
    func didEnterSearch(_ search: String) {
        hasCalledDidEnterSearch = true
    }
    
    func didSelectMovie(_ movie: MovieEntity, poster: PosterEntity?) {
        hasCalledDidSelectMovie = true
    }
    
    func didDeleteFavorite(movie: MovieEntity) {
        hasCalledDidDeleteFavorite = true
    }
    
    func didPressFilter() {
        hasCalledPressFilter = true
    }
    
}

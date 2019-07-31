//
//  FavoriteMoviesContract.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 25/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import UIKit

/**
 VIPER contract to FavoriteMovies module
 */

protocol FavoriteMoviesView: class {
    var presenter: FavoriteMoviesPresentation! { get set }
    var isFilterActive: Bool! { get set }
    
    func showNoContentScreen(image: UIImage?, message: String)
    func showFavoriteMoviesList(_ movies: [MovieEntity], posters: [PosterEntity])
    func adjustConstraints()
}

protocol FavoriteMoviesPresentation: class {
    var view: FavoriteMoviesView? { get set }
    var interactor: FavoriteMoviesUseCase! { get set }
    var router: FavoriteMoviesWireframe! { get set }
    
    var filters: Dictionary<String, String>? { get set }
    
    func viewDidLoad()
    func didEnterSearch(_ search: String)
    func didSelectMovie(_ movie: MovieEntity, poster: PosterEntity?)
    func didDeleteFavorite(movie: MovieEntity)
    func didPressFilter()
}

protocol FavoriteMoviesUseCase: class {
    var output: FavoriteMoviesInteractorOutput! { get set }
    
    func fetchFavoriteMovies()
}

protocol FavoriteMoviesInteractorOutput: class {
    func fetchedFavoriteMovies(_ : [MovieEntity], posters: [PosterEntity])
    func fetchedFavoriteMoviesFailed()
}

protocol FavoriteMoviesWireframe: class {
    var viewController: UIViewController? { get set }

    func presentFavoriteMovieDescription(movie: MovieEntity, genres: [GenreEntity], poster: PosterEntity?)
    func presentMoviesList()
    func presentFilterSelection(movies: [MovieEntity])
    
    static func assembleModule() -> UIViewController
}


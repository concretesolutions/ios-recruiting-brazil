//
//  ListMoviesContract.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 24/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import UIKit

/**
 VIPER contract to ListMovies module
 */

protocol ListMoviesView: class {
    var presenter: ListMoviesPresentation! { get set }
    
    func showNoContentScreen(image: UIImage?, message: String)
    func showMoviesList(_ movies: [MovieEntity])
    func updatePosters(_ posters: [PosterEntity])
    func adjustConstraints()
}

protocol ListMoviesPresentation: class {
    var view: ListMoviesView? { get set }
    var interactor: ListMoviesUseCase! { get set }
    var router: ListMoviesWireframe! { get set }
    
    func viewDidLoad()
    func didEnterSearch(_ search: String)
    func didSelectMovie(_ movie: MovieEntity)
}

protocol ListMoviesUseCase: class {
    var output: ListMoviesInteractorOutput! { get set }
    
    func fetchGenres()
    func fetchMovies()
    func fetchPosters(movies: [MovieEntity])
}

protocol ListMoviesInteractorOutput: class {
    func fetchedGenres(_ : GenresEntity)
    func fetchedGenresFailed()
    func fetchedMovies(_ : [MovieEntity])
    func fetchedMoviesFailed()
    func fetchedPoster(_ : PosterEntity)
    func fetchedPosterFailed()
    
}

protocol ListMoviesWireframe: class {
    var viewController: UIViewController? { get set }
    
    func presentMovieDescription(movie: MovieEntity, genres: [GenreEntity], poster: PosterEntity?)
    func presentFavoriteMovies()
    
    static func assembleModule() -> UIViewController
}

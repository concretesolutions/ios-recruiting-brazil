//
//  MoviesContract.swift
//  Movies
//
//  Created by Renan Germano on 19/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

protocol MoviesView: class {
    
    var presenter: MoviesPresentation! { get set }
    
    func present(movies: [Movie])
    func presentNew(movies: [Movie])
}

protocol MoviesPresentation {
    
    var view: MoviesView? { get set }
    var router: MoviesWireframe! { get set }
    var interactor: MoviesUseCase! { get set }
    
    func viewDidLoad()
    func didSelect(movie: Movie)
    func didTapFavoriteButton(forMovie: Movie)
    func didSearchMovies(withTitle: String)
    func didFinishSearch()
    
}

protocol MoviesUseCase {
    
    var output: MoviesInteractorOutput! { get set }
    
    func getMovies(fromPage page: Int)
    func getCurrentMovies()
    func searchMovies(withTitle title: String)
    func favorite(movie: Movie)
    func unfavorite(movie: Movie)
}

protocol MoviesInteractorOutput {
    
    func didGetMovies(fromPage page: Int, _ movies: [Movie])
    func didGetCurrentMovies(_ movies: [Movie])
    func didSearchMovies(withTitle title: String, _ movies: [Movie])
    
}

protocol MoviesWireframe {
    
    var view: UIViewController? { get set }
    
    func presentMovieDetailsFor(_ movie: Movie)
    
    static func assembleModule() -> UIViewController
    
}

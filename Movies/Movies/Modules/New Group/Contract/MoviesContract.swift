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
    func didTapFavoriteButtonTo(movie: Movie)
    func didSearchMoviesWith(name: String)
    
}

protocol MoviesUseCase {
    
    var output: MoviesInteractorOutput! { get set }
    
    func readMoviesFor(page: Int)
    func filterMoviesWith(name: String)
    func removeFilter()
    func favorite(movie: Movie)
    func unfavorite(movie: Movie)
}

protocol MoviesInteractorOutput {
    
    func didReadMoviesForPage(_ page: Int, _ movies: [Movie])
    func didFilterMoviesWithName(_ name: String, _ movies: [Movie])
    func didRemoveFilter(_ movies: [Movie])
    
}

protocol MoviesWireframe {
    
    var view: UIViewController? { get set }
    
    func presentMovieDetailsFor(_ movie: Movie)
    
    static func assembleModule() -> UIViewController
    
}

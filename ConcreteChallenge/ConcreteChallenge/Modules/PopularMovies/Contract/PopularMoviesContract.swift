//
//  PopularMoviesContract.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

protocol PopularMoviesWireframe: class {
    var viewController: UIViewController? { get set }
    static var presenter: PopularMoviesPresentation! { get set }
    
    static func assembleModule() -> UIViewController
    
    func showMoveDetail(for movie: Movie)
}

protocol PopularMoviesView {
    var presenter: PopularMoviesPresentation! { get set }
    
    func show(movies: [Movie])
    func showErrorMessage()
    func setActivityIndicator(to activated: Bool)
}

protocol PopularMoviesPresentation: class {
    var view: PopularMoviesView? { get set }
    var interactor: PopularMoviesInteractorInput! { get set }
    var router: PopularMoviesWireframe! { get set }
    
    func viewDidLoad()
    func didRequestMovies()
    func didTapMovieCell(of movie: Movie)
    func didChangeSearchBar(with text: String)
}

protocol PopularMoviesInteractorInput: class {
    var output: PopularMoviesInteractorOutput! { get set }
    
    func fetchMovies()
    func searchMovies(with text: String)
}

protocol PopularMoviesInteractorOutput: class {
    func didFetch(movies: [Movie])
    func didFailedToFetchMovies()
    func didSearchMovies(filteredMovies: [Movie])
}



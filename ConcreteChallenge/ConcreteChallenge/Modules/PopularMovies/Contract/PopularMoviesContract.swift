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
}

protocol PopularMoviesPresentation: class {
    var view: PopularMoviesView? { get set }
    var interactor: PopularMoviesInteractorInput! { get set }
    var router: PopularMoviesWireframe! { get set }
    
    func viewDidLoad()
    func didRequestMovies()
    func didTapMovieCell(of movie: Movie)
}

protocol PopularMoviesInteractorInput: class {
    var output: PopularMoviesInteractorOutput! { get set }
    
    func fetchMovies()
}

protocol PopularMoviesInteractorOutput: class {
    func didFetch(movies: [Movie])
}



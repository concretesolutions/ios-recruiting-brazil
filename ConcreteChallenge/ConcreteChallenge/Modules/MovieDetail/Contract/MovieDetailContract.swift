//
//  MovieDetailContract.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

protocol MovieDetailWireframe: class {
    var viewController: UIViewController? { get set }
    static var presenter: MovieDetailPresentation! { get set }
    
    static func assembleModule(with movie: Movie) -> UIViewController
}

protocol MovieDetailView {
    var presenter: MovieDetailPresentation! { get set }
    
    func showDetails(of movie: MovieDetails)
    func updateFavoriteButton(to activate:Bool)
}

protocol MovieDetailPresentation: class {
    var view: MovieDetailView? { get set }
    var interactor: MovieDetailInteractorInput! { get set }
    var router: MovieDetailWireframe! { get set }
    
    var movie: Movie! { get set }
    
    func viewDidLoad()
    func didTapFavoriteButton(of movie: MovieDetails)
}

protocol MovieDetailInteractorInput: class {
    var output: MovieDetailInteractorOutput! { get set }
    
    func fetchMovieDetails(movie: Movie)
    func addMovieToFavorite(movie: MovieDetails)
}

protocol MovieDetailInteractorOutput: class {
    func didFetchMovieDetails(movieDetails: MovieDetails)
    func didAddMovieToFavorite()
}



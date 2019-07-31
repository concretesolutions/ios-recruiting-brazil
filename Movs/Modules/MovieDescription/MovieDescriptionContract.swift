//
//  MovieDescriptionContract.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 26/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import UIKit

/**
 VIPER contract to MovieDescription module
 */

protocol MovieDescriptionView: class {
    var presenter: MovieDescriptionPresentation! { get set }
    
    func showNoContentScreen()
    func showMovieDescription(movie: MovieEntity, genres: String, poster: PosterEntity?)
    func adjustConstraints()
}

protocol MovieDescriptionPresentation: class {
    var view: MovieDescriptionView? { get set }
    var router: MovieDescriptionWireframe! { get set }
    //var interactor: MovieDescriptionUseCase! { get set }
    //var movie: MovieEntity { get set }
    
    func viewDidLoad()
    func didFavoriteMovie()
}

//protocol MovieDescriptionUseCase: class {
//    var output: MovieDescriptionInteractorOutput! { get set }
//}
//
//protocol MovieDescriptionInteractorOutput: class {
//
//}

protocol MovieDescriptionWireframe: class {
//    var viewController: UIViewController? { get set }

//    func presentFavoriteMovies()
//    func presentMoviesList()
    
    static func assembleModule(movie: MovieEntity, genres: [GenreEntity], poster: PosterEntity?) -> UIViewController
}

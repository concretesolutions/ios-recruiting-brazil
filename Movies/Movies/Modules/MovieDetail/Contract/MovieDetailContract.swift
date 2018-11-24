//
//  MovieDetailContract.swift
//  Movies
//
//  Created by Renan Germano on 24/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

protocol MovieDetailView: class {
    
    var presenter: MovieDetailPresentation! { get set }
    
    func present(movie: Movie)
    
}

protocol MovieDetailPresentation {
    
    var view: MovieDetailView? { get set }
    var router: MovieDetailWireframe! { get set }
    var interactor: MovieDetailUseCase! { get set }
    
    func viewDidLoad()
    func didTapFavoriteButton(forMovie movie: Movie)
    
}

protocol MovieDetailUseCase {
    
    var output: MovieDetailInteractorOutput! { get set }
    var movie: Movie! { get set }
    
    func getMovie()
    func favorite(movie: Movie)
    func unfavorite(movie: Movie)
    
}

protocol MovieDetailInteractorOutput {
    func didGet(movie: Movie)
}

protocol MovieDetailWireframe {
    
    var view: UIViewController? { get set }
    
    static func assembleModule() -> UIViewController
    
}

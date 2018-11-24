//
//  MovieDetailRouter.swift
//  Movies
//
//  Created by Renan Germano on 24/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

class MovieDetailRouter: MovieDetailWireframe {
    
    // MARK: - Properties
    
    var view: UIViewController?
    
    // MARK: - MoviewDetailWireframe protocol functions
    
    static func assembleModule(withMovie movie: Movie) -> UIViewController {
        
        let presenter = MovieDetailPresenter()
        let interactor = MovieDetailInteractor()
        let router = MovieDetailRouter()
        
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        interactor.movie = movie
        
        let storyboard = UIStoryboard(name: "MovieDetail", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MovieDetail")
        
        router.view = viewController
        
        if let movieDetailViewController = viewController as? MovieDetailView {
            movieDetailViewController.presenter = presenter
            presenter.view = movieDetailViewController
        }
        
        return viewController
        
    }
    
}

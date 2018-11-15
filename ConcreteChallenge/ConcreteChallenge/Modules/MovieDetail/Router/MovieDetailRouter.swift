//
//  MovieDetailRouter.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

class MovieDetailRouter: MovieDetailWireframe {
    
    weak var viewController: UIViewController?
    static var presenter: MovieDetailPresentation!
    
    static func assembleModule(with movie: Movie) -> UIViewController {
        let presenter = MovieDetailPresenter()
        let interactor = MovieDetailInteractor()
        let router = MovieDetailRouter()
        
        let storyboard = UIStoryboard(name: "MovieDetail", bundle: nil)
        var viewController = storyboard.instantiateViewController(withIdentifier: "MovieDetail")
        
        if let MovieDetailViewController = viewController as? MovieDetailTableViewController {
            MovieDetailViewController.presenter = presenter
            presenter.view = MovieDetailViewController
            router.viewController = MovieDetailViewController
        }
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.movie = movie
        
        interactor.output = presenter
        
        self.presenter = presenter
        
        return viewController
    }
}

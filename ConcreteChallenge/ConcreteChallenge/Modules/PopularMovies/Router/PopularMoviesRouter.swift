//
//  PopularMoviesRouter.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

class PopularMoviesRouter: PopularMoviesWireframe {
    
    
    weak var viewController: UIViewController?
    static var presenter: PopularMoviesPresentation!
    
    static func assembleModule() -> UIViewController {
        let presenter = PopularMoviesPresenter()
        let interactor = PopularMoviesInteractor()
        let router = PopularMoviesRouter()
        
        let storyboard = UIStoryboard(name: "PopularMovies", bundle: nil)
        var viewController = storyboard.instantiateViewController(withIdentifier: "PopularMovies")
        
        if let popularMoviesViewController = viewController as? PopularMoviesViewController {
            popularMoviesViewController.presenter = presenter
            presenter.view = popularMoviesViewController
            router.viewController = popularMoviesViewController
        }
        
        viewController = UINavigationController(rootViewController: viewController)
        
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        self.presenter = presenter
        
        return viewController
    }
    
    func showMoveDetail(for movie: Movie) {
        let movieDetailViewController = MovieDetailRouter.assembleModule(with: movie)
        self.viewController?.navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}

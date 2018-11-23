//
//  FavoritesRouter.swift
//  Movies
//
//  Created by Renan Germano on 23/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

class FavoritesRouter: FavoritesWireframe {
    
    // MARK: - Properties
    
    weak var view: UIViewController?
    
    // MARK: - FavoritesWireframe protocol functions
    
    func presentMovieDetailsFor(_ movie: Movie) {
        print("FavoritesRouter.presentMovieDetailsFor: \(movie.title)")
    }
    
    func presentFiltersView() {
        print("FavoritesRouter.presentFiltersView")
    }
    
    static func assembleModule() -> UIViewController {
        
        let presenter = FavoritesPresenter()
        let interactor = FavoritesInteractor()
        let router = FavoritesRouter()
        
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        let storyboard = UIStoryboard(name: "Favorites", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Favorites")
        
        router.view = viewController
        
        if let favoritesViewController = viewController as? FavoritesView {
            favoritesViewController.presenter = presenter
            presenter.view = favoritesViewController
        }
        
        let navigation = UINavigationController(rootViewController: viewController)
        
        return navigation
        
    }
    
    
}

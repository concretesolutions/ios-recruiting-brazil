//
//  FavoriteMoviesFactory.swift
//  Movs
//
//  Created by Maisa on 27/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import Foundation

/**
 Class to build view controller's dependency tree. Makes and links ViewController, Interactor, and Presenter objects.
 */
class FavoriteMoviesSceneConfigurator {
    
    static func inject(dependenciesFor viewController: FavoriteMoviesViewController) {
        if viewController.interactor != nil {
            return
        }
        
        let presenter = FavoriteMoviesPresenter()
        presenter.viewController = viewController
        
        let interactor = FavoriteMoviesInteractor()
        interactor.presenter = presenter
        
        viewController.interactor = interactor
        
    }
    
}

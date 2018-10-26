//
//  DetailMoviesFactory.swift
//  Movs
//
//  Created by Maisa on 24/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import Foundation

/**
 Class to build view controller's dependency tree. Makes and links ViewController, Interactor, and Presenter objects.
 */
class DetailMoviesSceneConfigurator {
    
    static func inject(dependenciesFor viewController: DetailMoviesViewController) {
        if viewController.interactor != nil {
            return
        }
        
        let presenter = DetailMoviesPresenter()
        presenter.viewController = viewController
        
        let interactor = DetailMoviesInteractor()
        interactor.presenter = presenter
        
        viewController.interactor = interactor
        
    }
    
}

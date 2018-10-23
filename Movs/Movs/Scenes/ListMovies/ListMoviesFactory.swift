//
//  ListMoviesFactory.swift
//  Movs
//
//  Created by Maisa on 23/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import Foundation

/**
 Class to build view controller's dependency tree. Makes and links ViewController, Interactor, and Presenter objects.
 */
class ListMoviesSceneConfigurator {
    
    static func inject(dependenciesFor viewController: ListMoviesViewController) {
        if viewController.interactor != nil {
            return
        }
        
        let presenter = ListMoviesPresenter()
        presenter.viewController = viewController
        
        let interactor = ListMoviesInteractor()
        interactor.presenter = presenter
        
        viewController.interactor = interactor
        
    }
    
}

//
//  FavoritesFilterRouter.swift
//  Movies
//
//  Created by Renan Germano on 25/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

class FavoritesFilterRouter: FavoritesFilterWireframe {
    
    // MARK: - Properties
    
    weak var view: UIViewController?
    
    // MARK: - FavoritesFilterWireframe protocol functions
    
    func dismiss() {
        self.view?.dismiss(animated: true, completion: nil)
    }
    
    static func assembleModule() -> UIViewController {
        
        let presenter = FavoritesFilterPresenter()
        let interactor = FavoritesFilterInteractor()
        let router = FavoritesFilterRouter()
        
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        let view = FavoritesFilterViewController()
        
        view.presenter = presenter
        presenter.view = view
        router.view = view
        
        return UINavigationController(rootViewController: view)
        
    }
    
    
    
    
}

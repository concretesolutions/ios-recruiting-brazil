//
//  FavoritesRouter.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 25/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//

import UIKit

class FavoritesRouter {
    var presenter: FavoritesPresenter!
    
    init() {
        
        //Instancing Storyboard
        let storyboard = UIStoryboard(name: "FavoritesCollectionViewController", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "FavoritesCollectionViewController")
        
        //Instancing View
        guard let view = viewController as? FavoritesCollectionViewController else {
            Logger.logError(in: FavoritesRouter.self, message: "Could not cast \(viewController) as FavoritesCollectionViewController")
            return
        }
        
        //Instancing Interactor
        let interactor = FavoritesInteractor()
        
        //Instancing Presenter
        self.presenter = FavoritesPresenter(router: self, interactor: interactor, view: view)
    }
    
    func goToMoviewDetail(movie:Movie) {
        let router = MovieDetailRouter(movie: movie)
        
        if let navigationController = self.presenter.view.navigationController {
            navigationController.pushViewController(router.presenter.view, animated: true)
        }else{
            self.presenter.view.present(router.presenter.view, animated: true, completion: nil)
        }
    }
}

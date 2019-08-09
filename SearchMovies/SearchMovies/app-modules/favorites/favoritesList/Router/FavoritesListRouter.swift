//
//  FavoritesListRouter.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 09/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

class FavoritesListRouter: PresenterToFavoritesListRouterProtocol {
    
    static func setModule(_ view:FavoritesListViewController) {
        
        let presenter:ViewToFavoritesListPresenterProtocol & IteractorToFavoritesListPresenterProtocol = FavoritesListPresenter()
        let iteractor:PresenterToFavoritesListIteractorProtocol = FavoritesListIteractor()
        let route:PresenterToFavoritesListRouterProtocol = FavoritesListRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.route = route
        presenter.iteractor = iteractor
        iteractor.presenter = presenter
    }
    
    func pushToScreen(_ view: FavoritesListViewController, segue: String, param: AnyObject?) {
         view.performSegue(withIdentifier: segue, sender: param)
    }
    
    
}

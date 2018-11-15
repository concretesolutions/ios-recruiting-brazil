//
//  FavoritesRouter.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 10/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class FavoritesRouter: NSObject {
    
    var presenter: FavoritesPresenter!
    
    override init() {
        super.init()
        // MARK: - VIPER
        // VIEW
        let storyboard = UIStoryboard(name: "FavoritesVC", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Favorites")
        guard let view = viewController as? FavoritesView else {
            //Logger.logError(in: self, message: "Could not cast \(viewController) as EnterViewController")
            return
        }
        // INTERACTOR
        let interactor = FavoritesInteractor()
        // PRESENTER
        self.presenter = FavoritesPresenter(router: self, interactor: interactor, view: view)
    }
    
    // FIXME: - DUPLICADO
    static var moduleStoryboard: UIStoryboard{
        return UIStoryboard(name:"MovieDetailsView",bundle: Bundle.main)
    }
    
}

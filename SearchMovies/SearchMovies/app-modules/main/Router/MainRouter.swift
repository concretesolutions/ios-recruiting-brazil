//
//  MainRouter.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 07/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

class MainRouter: PresenterToMainRouterProtocol {
    
    static func setModule(_ view:MainTabBarController) {
        
        let presenter:ViewToMainPresenterProtocol & IteractorToMainPresenterProtocol = MainPresenter()
        let iteractor:PresenterToMainIteractorProtocol = MainIteractor()
        let route:PresenterToMainRouterProtocol = MainRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.route = route
        presenter.iteractor = iteractor
        iteractor.presenter = presenter
    }
    
    func pushToScreen(_ view: MainTabBarController, segue: String) {
        view.performSegue(withIdentifier: segue, sender: nil)
    }
}

//
//  FilterSelectRouter.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 10/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

class FilterSelectRouter: PresenterToFilterSelectRouterProtocol {
    
    static func setModule(_ view:FilterSelectViewController) {
        
        let presenter:ViewToFilterSelectPresenterProtocol & IteractorToFilterSelectPresenterProtocol = FilterSelectPresenter()
        let iteractor:PresenterToFilterSelectIteractorProtocol = FilterSelectIteractor()
        let route:PresenterToFilterSelectRouterProtocol = FilterSelectRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.route = route
        presenter.iteractor = iteractor
        iteractor.presenter = presenter
    }
    
    func pushToScreen(_ view: FilterSelectViewController, segue: String, param: AnyObject?) {
        view.performSegue(withIdentifier: segue, sender: param)
    }
    
    func dismiss(_ view: FilterSelectViewController, animated: Bool) {
        view.dismiss(animated: animated, completion: nil)
    }
    
    
}

//
//  FilterResultRouter.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 10/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

class FilterResultRouter: PresenterToFilterResultRouterProtocol {
    
    static func setModule(_ view:FilterResultViewController) {
        
        let presenter:ViewToFilterResultPresenterProtocol & IteractorToFilterResultPresenterProtocol = FilterResultPresenter()
        let iteractor:PresenterToFilterResultIteractorProtocol = FilterResultIteractor()
        let route:PresenterToFilterResultRouterProtocol = FilterResultRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.route = route
        presenter.iteractor = iteractor
        iteractor.presenter = presenter
    }
    
    func pushToScreen(_ view: FilterResultViewController, segue: String, param: AnyObject?) {
        view.performSegue(withIdentifier: segue, sender: param)
    }
    
    func dismiss(_ view: FilterResultViewController, animated: Bool) {
        view.dismiss(animated: animated, completion: nil)
    }
    
    
}

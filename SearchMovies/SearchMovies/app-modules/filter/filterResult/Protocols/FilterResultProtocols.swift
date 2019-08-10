//
//  FilterResultProtocols.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 10/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

protocol ViewToFilterResultPresenterProtocol:class {
    var view:PresenterToFilterResultViewProtocol?{get set}
    var iteractor:PresenterToFilterResultIteractorProtocol?{get set}
    var route:PresenterToFilterResultRouterProtocol?{get set}
    
    
}

protocol PresenterToFilterResultIteractorProtocol:class {
    var presenter:IteractorToFilterResultPresenterProtocol? {get set}
    
}

protocol PresenterToFilterResultRouterProtocol:class {
    func pushToScreen(_ view: FilterResultViewController, segue: String, param:AnyObject?)
    func dismiss(_ view: FilterResultViewController, animated:Bool)
}

protocol IteractorToFilterResultPresenterProtocol:class {
    
}

protocol PresenterToFilterResultViewProtocol:class {
    
}

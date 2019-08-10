//
//  FilterSelectProtocols.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 10/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

protocol ViewToFilterSelectPresenterProtocol:class {
    var view:PresenterToFilterSelectViewProtocol?{get set}
    var iteractor:PresenterToFilterSelectIteractorProtocol?{get set}
    var route:PresenterToFilterSelectRouterProtocol?{get set}
    
    
}

protocol PresenterToFilterSelectIteractorProtocol:class {
    var presenter:IteractorToFilterSelectPresenterProtocol? {get set}
    
}

protocol PresenterToFilterSelectRouterProtocol:class {
    func pushToScreen(_ view: FilterSelectViewController, segue: String, param:AnyObject?)
    func dismiss(_ view: FilterSelectViewController, animated:Bool)
}

protocol IteractorToFilterSelectPresenterProtocol:class {
    
}

protocol PresenterToFilterSelectViewProtocol:class {
    
}

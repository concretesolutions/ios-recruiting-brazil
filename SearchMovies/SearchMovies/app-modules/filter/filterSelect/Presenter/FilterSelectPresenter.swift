//
//  FilterSelectPresenter.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 10/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

class FilterSelectPresenter: ViewToFilterSelectPresenterProtocol {
    weak var view: PresenterToFilterSelectViewProtocol?
    
    var iteractor: PresenterToFilterSelectIteractorProtocol?
    
    var route: PresenterToFilterSelectRouterProtocol?
    
    
}

extension FilterSelectPresenter : IteractorToFilterSelectPresenterProtocol {
    
}

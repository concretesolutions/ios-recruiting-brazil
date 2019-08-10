//
//  FilterResultPresenter.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 10/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

class FilterResultPresenter: ViewToFilterResultPresenterProtocol {
    weak var view: PresenterToFilterResultViewProtocol?
    
    var iteractor: PresenterToFilterResultIteractorProtocol?
    
    var route: PresenterToFilterResultRouterProtocol?
    
    
}

extension FilterResultPresenter: IteractorToFilterResultPresenterProtocol {
    
}

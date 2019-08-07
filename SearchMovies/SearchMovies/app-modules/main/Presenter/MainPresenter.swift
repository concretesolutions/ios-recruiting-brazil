//
//  MainPresenter.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 07/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

class MainPresenter: ViewToMainPresenterProtocol {
    var view: PresenterToMainViewProtocol?
    
    var iteractor: PresenterToMainIteractorProtocol?
    
    var route: PresenterToMainRouterProtocol?
    
    func loadMainMenu() {
         
    }
    
    
}

extension MainPresenter:IteractorToMainPresenterProtocol {
    func returnMainMenu(menuList: [MainMenu]) {
        
    }
}

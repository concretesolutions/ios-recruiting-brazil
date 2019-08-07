//
//  MainProtocols.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 07/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

protocol ViewToMainPresenterProtocol:class {
    var view:PresenterToMainViewProtocol?{get set}
    var iteractor:PresenterToMainIteractorProtocol?{get set}
    var route:PresenterToMainRouterProtocol?{get set}
    func loadMainMenu()
}

protocol PresenterToMainIteractorProtocol:class {
    var presenter:IteractorToMainPresenterProtocol? {get set}
    func loadMainMenu()
}

protocol PresenterToMainRouterProtocol:class {
    func pushToScreen(_ view: MainTabBarController, segue: String)
}

protocol IteractorToMainPresenterProtocol:class {
    func returnMainMenu(menuList:[MainMenu])
}

protocol PresenterToMainViewProtocol:class {
    func returnMainMenu(menuList:[MainMenu])
}

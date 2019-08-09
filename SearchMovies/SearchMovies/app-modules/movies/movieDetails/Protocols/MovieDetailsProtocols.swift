//
//  MovieDetailsProtocols.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 08/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

protocol ViewToMovieDetailsPresenterProtocol:class {
    var view:PresenterToMovieDetailsViewProtocol?{get set}
    var iteractor:PresenterToMovieDetailsIteractorProtocol?{get set}
    var route:PresenterToMovieDetailsRouterProtocol?{get set}
    func loadMainMenu()
}

protocol PresenterToMovieDetailsIteractorProtocol:class {
    var presenter:IteractorToMovieDetailsPresenterProtocol? {get set}
    func loadMainMenu()
}

protocol PresenterToMovieDetailsRouterProtocol:class {
    func pushToScreen(_ view: MovieDetailsViewController, segue: String)
}

protocol IteractorToMovieDetailsPresenterProtocol:class {
    func returnMainMenu(menuList:[MainMenu])
}

protocol PresenterToMovieDetailsViewProtocol:class {
    func returnMainMenu(menuList:[MainMenu])
}

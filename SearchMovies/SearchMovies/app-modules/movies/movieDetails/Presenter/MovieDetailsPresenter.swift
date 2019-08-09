//
//  MovieDetailsPresenter.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 08/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

class MovieDetailsPresenter: ViewToMovieDetailsPresenterProtocol {
    weak var view: PresenterToMovieDetailsViewProtocol?
    
    var iteractor: PresenterToMovieDetailsIteractorProtocol?
    
    var route: PresenterToMovieDetailsRouterProtocol?
    
    func loadMainMenu() {
         
    }
    
    
}

extension MovieDetailsPresenter : IteractorToMovieDetailsPresenterProtocol {
    func returnMainMenu(menuList: [MainMenu]) {
         
    }
    
    
}

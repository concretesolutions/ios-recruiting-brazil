//
//  MovieListRouter.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 07/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

class MovieListRouter: PresenterToMovieListRouterProtocol {
    
    static func setModule(_ view:MovieListViewController) {
        
        let presenter:ViewToMovieListPresenterProtocol & IteractorToMovieListPresenterProtocol = MovieListPresenter()
        let iteractor:PresenterToMovieListIteractorProtocol = MovieListIteractor()
        let route:PresenterToMovieListRouterProtocol = MovieListRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.route = route
        presenter.iteractor = iteractor
        iteractor.presenter = presenter
    }
    
    func pushToScreen(_ view: MovieListViewController, segue: String, param: AnyObject?) {
        view.performSegue(withIdentifier: segue, sender: param)
    }
    
    
}

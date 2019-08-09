//
//  MovieDetailsRouter.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 08/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

class MovieDetailsRouter: PresenterToMovieDetailsRouterProtocol {
    
    static func setModule(_ view:MovieDetailsViewController) {
        
        let presenter:ViewToMovieDetailsPresenterProtocol & IteractorToMovieDetailsPresenterProtocol = MovieDetailsPresenter()
        let iteractor:PresenterToMovieDetailsIteractorProtocol = MovieDetailsIteractor()
        let route:PresenterToMovieDetailsRouterProtocol = MovieDetailsRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.route = route
        presenter.iteractor = iteractor
        iteractor.presenter = presenter
    }
    
    func pushToScreen(_ view: MovieDetailsViewController, segue: String) {
        view.performSegue(withIdentifier: segue, sender: nil)
    }
    
    func dismiss(_ view: MovieDetailsViewController, animated: Bool) {
        view.dismiss(animated: animated, completion: nil)
    }
}

//
//  MovieDetailRouter.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 25/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//

import UIKit

class MovieDetailRouter {
    var presenter: MovieDetailPresenter!
    
    init(movie:Movie) {
        
        //Instancing Storyboard
        let storyboard = UIStoryboard(name: "MovieDetailTableViewController", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailTableViewController")
        
        //Instancing View
        guard let view = viewController as? MovieDetailViewController else {
            Logger.logError(in: MovieDetailRouter.self, message: "Could not cast \(viewController) as MovieDetailViewController")
            return
        }
        
        //Instancing Interactor
        let interactor = MovieDetailInteractor(movie: movie)
        
        //Instancing Presenter
        self.presenter = MovieDetailPresenter(router: self, interactor: interactor, view: view)
    }
    
    func showAlert(message:String) {
        
    }
}

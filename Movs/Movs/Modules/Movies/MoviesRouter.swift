//
//  MoviesRouter.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 10/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class MoviesRouter: NSObject {
    
    var presenter: MoviesPresenter!
    
    override init() {
        super.init()
        // MARK: - VIPER
        // VIEW
        let storyboard = UIStoryboard(name: "MoviesVC", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Movies")
        guard let view = viewController as? MoviesView else {
            print("Error: Could not cast \(viewController) as MoviesView")
            return
        }
        // INTERACTOR
        let interactor = MoviesInteractor()
        // PRESENTER
        self.presenter = MoviesPresenter(router: self, interactor: interactor, view: view)
    }
    
    // MARK: - FROM PRESENTER
    
    func goToMovieDetail(movieID: Int) {
        let router = MovieDetailsRouter.init(id: movieID)
        
        if let navigationController = self.presenter.view.navigationController as? CustomNavigation {
            navigationController.pushViewController(router.presenter.view, animated: true)
        }else{
            self.presenter.view.present(router.presenter.view, animated: true, completion: nil)
        }
    }
    
}


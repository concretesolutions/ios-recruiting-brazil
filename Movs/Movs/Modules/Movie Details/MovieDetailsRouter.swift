//
//  MovieDetailsRouter.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 14/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class MovieDetailsRouter: NSObject {
    
    var presenter: MovieDetailsPresenter!
    
    init(id: Int) {
        super.init()
        // MARK: - VIPER
        // VIEW
        let storyboard = UIStoryboard(name: "MovieDetailsView", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MovieDetail")
        guard let view = viewController as? MovieDetailsView else {
            //Logger.logError(in: self, message: "Could not cast \(viewController) as EnterViewController")
            return
        }
        // INTERACTOR
        let interactor = MovieDetailsInteractor(movieID: id)
        // PRESENTER
        self.presenter = MovieDetailsPresenter(router: self, interactor: interactor, view: view)
    }
    
}

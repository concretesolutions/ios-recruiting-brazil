//
//  MoviesRouter.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 17/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//

import UIKit

class MoviesRouter: NSObject {
    
    var presenter: MoviesPresenter!
    
    override init() {
        
        //
        super.init()
        
        //Instancing Storyboard
        let storyboard = UIStoryboard(name: "MoviesViewController", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MoviesViewController")
        
        //Instancing View
        guard let view = viewController as? MoviesViewController else {
            Logger.logError(in: MoviesRouter.self, message: "Could not cast \(viewController) as MoviesViewController")
            return
        }
        
        //Instancing Interactor
        let interactor = MoviesInteractor()
        
        
        //Instancing Presenter
        self.presenter = MoviesPresenter(router: self, interactor: interactor, view: view)
    }
    
    // MARK: - Go To
    func goToMoviewDetail(movie:Movie) {
        Logger.log(in: self, message: "Go to MovieDetail of \(movie.title ?? "No title")")
    }
}

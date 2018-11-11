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
            //Logger.logError(in: self, message: "Could not cast \(viewController) as EnterViewController")
            return
        }
        // INTERACTOR
        let interactor = MoviesInterector()
        // PRESENTER
        self.presenter = MoviesPresenter(router: self, interactor: interactor, view: view)
    }
    
    // FIXME: - DUPLICADO
    static var moduleStoryboard: UIStoryboard{
        return UIStoryboard(name:"MoviesVC",bundle: Bundle.main)
    }
    
//    func presentLoginScreen(from view: UserPresenterToViewProtocol) {
//        let loginViewController = LoginRouter.createModule(with: nil)
//
//        if let sourceView = view as? UIViewController {
//            sourceView.present(loginViewController, animated: true, completion: nil)
//            //sourceView.navigationController?.pushViewController(loginViewController, animated: true)
//        }
//
//    }
    
}


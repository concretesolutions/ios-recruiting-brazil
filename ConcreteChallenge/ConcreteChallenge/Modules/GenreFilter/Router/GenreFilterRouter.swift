//
//  GenreFilterRouter.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

class GenreFilterRouter: GenreFilterWireframe {
    
    weak var viewController: UIViewController?
    static var presenter: GenreFilterPresentation!
    
    static func assembleModule() -> UIViewController {
        let presenter = GenreFilterPresenter()
        let interactor = GenreFilterInteractor()
        let router = GenreFilterRouter()
        
        let storyboard = UIStoryboard(name: "GenreFilter", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "GenreFilter")
        
        if let GenreFilterViewController = viewController as? GenreFilterTableViewController {
            GenreFilterViewController.presenter = presenter
            presenter.view = GenreFilterViewController
            router.viewController = GenreFilterViewController
        }
        
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        self.presenter = presenter
        return viewController
    }
    
    func didTapSaveButton() {
        FilterRouter.didSetGenreFilter()
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}

//
//  FilterRouter.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

class FilterRouter: FilterWireframe {
    
    weak var viewController: UIViewController?
    static var presenter: FilterPresentation!
    
    static func assembleModule() -> UIViewController {
        let presenter = FilterPresenter()
        let interactor = FilterInteractor()
        let router = FilterRouter()
        
        let storyboard = UIStoryboard(name: "Filter", bundle: nil)
        var viewController = storyboard.instantiateViewController(withIdentifier: "Filter")
        
        if let FilterViewController = viewController as? FilterTableViewController {
            FilterViewController.presenter = presenter
            presenter.view = FilterViewController
            router.viewController = FilterViewController
        }
        
        viewController = UINavigationController(rootViewController: viewController)
        
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        self.presenter = presenter
        
        return viewController
    }
    
    func showDateFilter() {
        let dateFilterViewController = DateFilterRouter.assembleModule()
        self.viewController?.navigationController?.pushViewController(dateFilterViewController, animated: true)
    }
    
    func showGenreFilter() {
        
    }
    
    static func didSetDateFilter() {
        self.presenter.didSetDateFilter()
    }
    
    func exitFilter() {
        self.viewController?.dismiss(animated: true, completion: nil)
    }
    
    func doneFilter() {
        self.viewController?.dismiss(animated: true, completion: {
            
        })
    }
    
    
}

//
//  DateFilterRouter.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

class DateFilterRouter: DateFilterWireframe {
    
    weak var viewController: UIViewController?
    static var presenter: DateFilterPresentation!
    var filterRouterDelegate: FilterRouterDelegate!
    
    static func assembleModule(filterRouterDelegate: FilterRouterDelegate) -> UIViewController {
        let presenter = DateFilterPresenter()
        let interactor = DateFilterInteractor()
        let router = DateFilterRouter()
        router.filterRouterDelegate = filterRouterDelegate
        
        let storyboard = UIStoryboard(name: "DateFilter", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DateFilter")
        
        if let DateFilterViewController = viewController as? DateFilterTableViewController {
            DateFilterViewController.presenter = presenter
            presenter.view = DateFilterViewController
            router.viewController = DateFilterViewController
        }
        
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        self.presenter = presenter
        
        return viewController
    }
    
    func exitWithDateFilter(dates: [Date]) {
        self.viewController?.navigationController?.popViewController(animated: true)
        self.filterRouterDelegate.didSetDateFilter(with: dates)
    }
}

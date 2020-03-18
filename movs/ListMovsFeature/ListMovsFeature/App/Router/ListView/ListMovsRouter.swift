//
//  RouterListMovsFeature.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 02/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit

open class ListMovsRouter: NSObject {
    
    var presenter: ListMovsPresenter!
    var view: ListMovsViewController!
    var service: ListMovsServiceType!
    var detailRouter: DetailItemMovsRouter?
    var navigationController: UINavigationController? {
        return view.navigationController
    }
    
    /// just module on open
    public override init() {}
    
    public func makeUI() -> ListMovsViewController {
        self.view = ListMovsViewController()
        self.service = ListMovsService()
        self.presenter = ListMovsPresenter(view: self.view,
                                           router: self,
                                           service: self.service)
        self.view.presenter = self.presenter
        
        return view
    }
    
    public func showDetailView(with itemView: MovsItemViewData) {
        self.detailRouter = DetailItemMovsRouter()
        if let ui = detailRouter?.makeUI(itemViewData: itemView) {            
            if let navController = navigationController {
                navController.delegate = self
                navController.pushViewController(ui, animated: true)
            } else {
                view.present(ui, animated: true)
            }
        }
    }
}

extension ListMovsRouter: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController,
                                     didShow viewController: UIViewController,
                                     animated: Bool) {
        
        if viewController is ListMovsViewController {
            self.detailRouter?.pop()
            self.detailRouter = nil
        }
    }
}

//
//  HomeFavoriteMovsRouter.swift
//  FavoriteMovsFeature
//
//  Created by Marcos Felipe Souza on 22/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit

open class HomeFavoriteMovsRouter {
    
    var viewController: HomeFavoriteMovsViewController!
    var presenter: HomeFavoriteMovsPresenter!
    
    public init() {}
    public func makeUI() -> HomeFavoriteMovsViewController {
        self.viewController = HomeFavoriteMovsViewController()
        
        self.presenter = HomeFavoriteMovsPresenter(view: viewController, router: self)
        self.viewController.presenter = presenter
        
        return self.viewController
    }
}

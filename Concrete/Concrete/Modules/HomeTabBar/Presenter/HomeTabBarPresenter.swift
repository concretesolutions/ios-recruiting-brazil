//
//  HomeTabBarPresenter.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 17/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//

import UIKit

class HomeTabBarPresenter: NSObject {
    // MARK: - Variables
    // MARK: Private
    // MARK: Public
    var router: HomeTabBarRouter
    var interactor: HomeTabBarInteractor
    var view: HomeTabBarViewController
    
    // MARK: - Initializers
    init(router: HomeTabBarRouter, interactor: HomeTabBarInteractor, view: HomeTabBarViewController) {
        self.router = router
        self.interactor = interactor
        self.view = view
        
        super.init()
        self.view.presenter = self
    }
    
    // MARK: - Functions
    // MARK: Private
    // MARK: Public
    func viewDidLoad() {
        //
    }
}

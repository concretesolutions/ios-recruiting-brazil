//
//  TabBarPresenter.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 15/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class TabBarPresenter{
    // MARK: - Variables
    // MARK: Private
    // MARK: Public
    var router:TabBarRouter
    var interactor:TabBarInteractor
    var view:TabBarView
    
    // MARK: - Initializers
    init(router:TabBarRouter, interactor:TabBarInteractor, view:TabBarView) {
        self.router = router
        self.interactor = interactor
        self.view = view
        self.view.presenter = self
    }
    
    // MARK: - Functions
    // MARK: Private
    // MARK: Public
    func viewDidLoad() {
        
    }
}

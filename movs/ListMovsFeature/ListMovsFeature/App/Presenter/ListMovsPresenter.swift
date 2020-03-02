//
//  ListMovsPresenter.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 02/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation

class ListMovsPresenter {
    
    weak var view: ListMovsView!
    unowned var router: ListMovsRouter!
    
    init(view: ListMovsView, router: ListMovsRouter) {
        self.view = view
        self.router = router
    }
}


//MARK: - Binding UI -
extension ListMovsPresenter {
    func loading() {
        self.view.loadViewController()
    }
    
    func tapOnButton(){
        //Do Something
    }
}

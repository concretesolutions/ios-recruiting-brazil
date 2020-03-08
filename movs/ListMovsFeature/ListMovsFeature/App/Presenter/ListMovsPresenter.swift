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
    unowned var router: ListMovsRouter
    var service: ListMovsServiceType
    
    init(view: ListMovsView, router: ListMovsRouter, service: ListMovsServiceType) {
        self.view = view
        self.router = router
        self.service = service
    }
}


//MARK: - Binding UI -
extension ListMovsPresenter {
    func loading() {
        self.view.loadViewController()
        self.view.setTitle("Movies")
        self.service.fetchDatas()
    }
    
    func tapOnButton(){
        //Do Something
    }
}

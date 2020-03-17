//
//  RouterListMovsFeature.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 02/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit

open class ListMovsRouter {
    
    var presenter: ListMovsPresenter!
    var view: ListMovsViewController!
    var service: ListMovsServiceType!
    
    
    public var showSearchView: () -> Void = {  
        print("GOTT HERE")
    }
    
    /// just module on open
    public init() {}
    
    public func makeUI() -> ListMovsViewController {
        self.view = ListMovsViewController()
        self.service = ListMovsService()
        self.presenter = ListMovsPresenter(view: self.view,
                                           router: self,
                                           service: self.service)
        self.view.presenter = self.presenter
        return view
    }
    
    public func showSearchVie2w() {
        self.showSearchView()
    }
    
}

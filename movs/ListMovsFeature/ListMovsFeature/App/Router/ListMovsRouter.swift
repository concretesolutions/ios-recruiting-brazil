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
    
    /// just module on open
    public init() {}
    
    public func makeUI() -> ListMovsViewController {
        self.view = ListMovsViewController()
        self.presenter = ListMovsPresenter(view: view, router: self)
        self.view.presenter = self.presenter
        return view
    }
    
}

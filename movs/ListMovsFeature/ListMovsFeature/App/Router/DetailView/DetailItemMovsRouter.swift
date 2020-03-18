//
//  DetailMovsRouter.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 17/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation


import UIKit

open class DetailItemMovsRouter {
    
    var view: DetailItemViewController!
    var presenter: DetailItemMovsPresenter!
    
    /// just module on open
    public init() {}
    
    public func makeUI(itemViewData: MovsItemViewData) -> DetailItemViewController {
        
        self.view = DetailItemViewController()
        self.presenter = DetailItemMovsPresenter(view: self.view!, itemViewData: itemViewData)
        self.view.presenter = self.presenter
        return view
    }
    
    public func pop() {
        self.view = nil
        self.presenter = nil
    }
    
    deinit {
        debugPrint("Testing with retain cycle")
    }
}


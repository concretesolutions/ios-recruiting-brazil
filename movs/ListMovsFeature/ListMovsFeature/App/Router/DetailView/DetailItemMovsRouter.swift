//
//  DetailMovsRouter.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 17/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation


import UIKit
import GenresFeature

open class DetailItemMovsRouter {
    
    var view: DetailItemViewController!
    var presenter: DetailItemMovsPresenter!
    var genreService: GenresFeatureServiceType!
    
    /// just module on open
    public init() {}
    
    public func makeUI(itemViewData: MovsItemViewData) -> DetailItemViewController {
        
        self.view = DetailItemViewController()
        self.genreService = GenresFeatureService()
        self.presenter = DetailItemMovsPresenter(view: self.view!,
                                                 itemViewData: itemViewData,
                                                 genreService: self.genreService)
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


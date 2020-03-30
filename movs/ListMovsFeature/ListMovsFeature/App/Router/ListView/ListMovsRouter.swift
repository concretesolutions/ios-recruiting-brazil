//
//  RouterListMovsFeature.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 02/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit
import ModelsFeature

open class ListMovsRouter {
    
    var presenter: ListMovsPresenter!
    var view: ListMovsViewController
    var service: ListMovsServiceType!
    var favoriteCoreData: FavoriteMovCoreDataType!
    public var detailView: ((_ itemViewData: MovsItemViewData) -> ())?
    
    
    public init(isTestable: Bool = false) {
        if !isTestable {
            self.service = ListMovsService()
            self.favoriteCoreData = FavoriteMovCoreData()
        }
        self.view = ListMovsViewController()
    }
    
    @discardableResult
    public func makeUI() -> ListMovsViewController {
        self.presenter = ListMovsPresenter(view: self.view,
                                           router: self,
                                           service: self.service,
                                           favoriteCoreData: self.favoriteCoreData)
        self.view.presenter = self.presenter
        return view
    }
    
    public func showDetailView(with itemView: MovsItemViewData) {
        self.detailView?(itemView)        
    }
}


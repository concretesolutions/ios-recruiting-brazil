//
//  HomeFavoriteMovsPresenter.swift
//  FavoriteMovsFeature
//
//  Created by Marcos Felipe Souza on 22/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation

protocol HomeFavoriteMovsView: AnyObject {
    func setTitle(_ text: String)
}

class HomeFavoriteMovsPresenter {
    
    var viewDataModel: HomeFavoriteViewData?
    weak var view: HomeFavoriteMovsView?
    weak var router: HomeFavoriteMovsRouter?
    
    init(view: HomeFavoriteMovsView, router: HomeFavoriteMovsRouter) {
        self.view = view
        self.router = router
    }    
}

//MARK: - Binding View
extension HomeFavoriteMovsPresenter {
    func loadingUI() {
        self.view?.setTitle("Movies")
    }
}

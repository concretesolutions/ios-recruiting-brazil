//
//  HomeFavoriteMovsPresenter.swift
//  FavoriteMovsFeature
//
//  Created by Marcos Felipe Souza on 22/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation
import ModelsFeature

protocol HomeFavoriteMovsView: AnyObject {
    func loadDatas(_ favoriteMovsModel: HomeFavoriteViewData)
}

class HomeFavoriteMovsPresenter {
    
    var viewDataModel: HomeFavoriteViewData?
    weak var view: HomeFavoriteMovsView?
    weak var router: HomeFavoriteMovsRouter?
    var coreData: FavoriteMovCoreData?
    
    private var viewData = HomeFavoriteViewData()
    init(view: HomeFavoriteMovsView, router: HomeFavoriteMovsRouter) {
        self.view = view
        self.router = router
        self.coreData = FavoriteMovCoreData()
    }    
}

//MARK: - Binding View
extension HomeFavoriteMovsPresenter {
    func loadingUI() {
        let favorites = self.fetchFavorites()
        
        viewData.title = "Movies"
        viewData.favorites = favorites
        self.view?.loadDatas(viewData)
    }
    
    func selected(favoriteModel: FavoriteMovsModel) {
        //print("selecionou ::::: \(favoriteModel.title)")
    }
    
    func remove(at favoriteModel: FavoriteMovsModel) {
        coreData?.deleteFavoriteMovs(model: favoriteModel)
    }
}

//MARK: - CoreData
extension HomeFavoriteMovsPresenter {
    func fetchFavorites() -> [FavoriteMovsModel] {
        return coreData?.fetchFavoriteMovs() ?? []
    }
}

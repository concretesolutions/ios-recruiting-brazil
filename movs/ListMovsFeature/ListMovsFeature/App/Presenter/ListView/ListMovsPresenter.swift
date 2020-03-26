//
//  ListMovsPresenter.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 02/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import NetworkLayerModule
import ModelsFeature

class ListMovsPresenter {
    weak var view: ListMovsView!
    weak var router: ListMovsRouter?
    var service: ListMovsServiceType
    var viewDataModel = MovsListViewData()
    var favoriteCoreData: FavoriteMovCoreData
    
    init(view: ListMovsView,
         router: ListMovsRouter,
         service: ListMovsServiceType,
         favoriteCoreData: FavoriteMovCoreData = FavoriteMovCoreData()) {
        self.view = view
        self.router = router
        self.service = service
        self.favoriteCoreData = favoriteCoreData
    }
}


//MARK: - Binding UI -
extension ListMovsPresenter {
    func loading() {
        self.view.setTitle("Movies")
        self.view.showLoading()
        self.service.fetchDatas(typeData: .cartoon) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.viewDataModel = self.wrapperModels(from: success)
                    self.checkFavorite()
                    self.view.showSuccess(viewData: self.viewDataModel)
                case .failure(_):
                    self.view.showErrorCard()
                }
                self.view.hideLoading()
            }
        }
        
    }
    
    func favoriteMovie(_ itemViewData: MovsItemViewData) {
        self.viewDataModel.items = self.viewDataModel.items.map{ item  in
            var copyItem = item
            if copyItem.id == itemViewData.id {
                copyItem.isFavorite.toggle()
            }
            return copyItem
        }
        
        if itemViewData.isFavorite {
            persistFavoriteMovie(itemViewData)
        } else {
            removeFavoriteMovie(itemViewData)
        }
        self.view.updateViewData(self.viewDataModel)
    }
    
    func searchingModel(_ search: String) {        
        
        let isEmpty = search.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
        if  isEmpty {
            self.view.reloadData(with: self.viewDataModel)
            
        } else {
            self.viewDataModel.textInSearchBar = search
            let itemsSearched = self.itemsInSearching(with: search)
            self.view.reloadData(with: MovsListViewData(textInSearchBar: search, items: itemsSearched))
        }
    }
    
    func showDetail(_ itemView: MovsItemViewData) {
        self.router?.showDetailView(with: itemView)
    }
}

//MARK: -Privates func-
extension ListMovsPresenter {
    private func itemsInSearching(with text: String) -> [MovsItemViewData] {
        return self.viewDataModel.items.filter { $0.movieName.contains(text) }
    }
    
    private func persistFavoriteMovie(_ itemViewData: MovsItemViewData) {
        let model = wrapperModelsToFavorite(from: itemViewData)
        favoriteCoreData.saveFavoriteMovs(model: model)
    }
    
    private func removeFavoriteMovie(_ itemViewData: MovsItemViewData) {
        let model = wrapperModelsToFavorite(from: itemViewData)
        favoriteCoreData.deleteFavoriteMovs(model: model)
    }
    
    private func checkFavorite() {
        
        let items = self.viewDataModel.items.map { item -> MovsItemViewData in
            var itemCopy = item
            let model = self.wrapperModelsToFavorite(from: item)
            if let _ = self.favoriteCoreData.search(by: model) {
                itemCopy.isFavorite = true
                return itemCopy
            }
            return item
        }
        
        self.viewDataModel.items = items
    }
}

//MARK: -Wrapper Models-
extension ListMovsPresenter {
    
    private func wrapperModelsToFavorite(from itemViewData: MovsItemViewData) -> FavoriteMovsModel {
        var model = FavoriteMovsModel()
        model.imageURL = itemViewData.imageMovieURLAbsolute
        model.owerview = itemViewData.overview
        model.title = itemViewData.movieName
        model.year = itemViewData.years
        return model
    }
    
    private func wrapperModels(from requestModel: MovsListRequestModel) -> MovsListViewData {
        var viewData = MovsListViewData()
        requestModel.items?.forEach { item in
            
            let absoluteURL = self.service.absoluteUrlImage(with: item.posterPath ?? "/")
            let movieName = (item.originalName ?? item.originalTitle) ?? ""
            
            var itemViewData = MovsItemViewData(id: item.id ?? 0,
                                                imageMovieURL: item.posterPath ?? "/",
                                                imageMovieURLAbsolute: absoluteURL,
                                                isFavorite: false,
                                                movieName: movieName,
                                                overview: item.overview ?? "")
            itemViewData.genresId = item.genreIDS ?? []
            
            if let firstAirDate = item.firstAirDate {
                
                let dateFormatterOrigin = DateFormatter()
                dateFormatterOrigin.dateFormat = "yyyy-MM-dd"
                if let dateOriginal = dateFormatterOrigin.date(from: firstAirDate) {
                    let dateFormatterView = DateFormatter()
                    dateFormatterView.dateFormat = "dd/MM/yyyy"
                    itemViewData.years = dateFormatterView.string(from: dateOriginal)
                }
            }
            viewData.items.append(itemViewData)
        }
        return viewData
    }
}

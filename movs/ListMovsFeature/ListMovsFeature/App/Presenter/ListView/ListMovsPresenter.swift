//
//  ListMovsPresenter.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 02/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import NetworkLayerModule

class ListMovsPresenter {
    weak var view: ListMovsView!
    var router: ListMovsRouter
    var service: ListMovsServiceType
    var viewDataModel = MovsListViewData()
    
    init(view: ListMovsView, router: ListMovsRouter, service: ListMovsServiceType) {
        self.view = view
        self.router = router
        self.service = service
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
        self.router.showDetailView(with: itemView)
    }
}

//MARK: -Privates func-
extension ListMovsPresenter {
    private func itemsInSearching(with text: String) -> [MovsItemViewData] {
        return self.viewDataModel.items.filter { $0.movieName.contains(text) }
    }
}

//MARK: -Wrapper Models-
extension ListMovsPresenter {
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
            viewData.items.append(itemViewData)
        }
        return viewData
    }
}

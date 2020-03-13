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
    unowned var router: ListMovsRouter
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
        self.view.reloadData(with: self.viewDataModel)
    }
}

//MARK: -Wrapper Models-
extension ListMovsPresenter {
    private func wrapperModels(from requestModel: MovsListRequestModel) -> MovsListViewData {
        var viewData = MovsListViewData()
        requestModel.items?.forEach { item in
            viewData.items.append(
                MovsItemViewData(id: item.id ?? 0,
                                 imageMovieURL: item.posterPath ?? "/",
                                 imageMovieURLAbsolute: self.service.absoluteUrlImage(with: item.posterPath ?? "/"),
                                 isFavorite: false,
                                 movieName: (item.originalName ?? item.originalTitle) ?? ""))
        }
        return viewData
    }
}

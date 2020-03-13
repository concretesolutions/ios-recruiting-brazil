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
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self?.view.showSuccess(viewData: success)
                case .failure(_):
                    self?.view.showErrorCard()
                }
                self?.view.hideLoading()
            }
        }
        
    }
    
    func urlForLoad(with viewData: MovsItemViewData) -> String {
        return self.service.absoluteUrlImage(with: viewData.imageMovieURL)
    }
    
    func stopLoad() {
        self.service.stopRequest()
    }
    
    func tapOnButton(){
        //Do Something
    }
}

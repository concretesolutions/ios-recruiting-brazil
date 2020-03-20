//
//  DetailItemMovsPresenter.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 17/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import GenresFeature

class DetailItemMovsPresenter {
    deinit {
        print("TESTE LIFECYCLE DA PRESENTER -- DetailItemMovsPresenter")
    }
    weak var view: DetailItemMovsView?
    var itemViewData: MovsItemViewData
    var genreService: GenresFeatureServiceType
    
    init(view: DetailItemMovsView,
         itemViewData: MovsItemViewData,
         genreService: GenresFeatureServiceType) {
        self.view = view
        self.itemViewData = itemViewData
        self.genreService = genreService
    }
    
}


//MARK: - UI Event - Actions -
extension DetailItemMovsPresenter {
    func loadingView() {
        self.view?.setTitle("Movies")
        self.view?.showLoading()
        
        self.genreService.fetchGenres { result in
            
            switch result {
            case .success(let models):
                print(models)
                self.view?.fillUp(with: self.itemViewData)
            case .failure(let error):
                print(error)
            }
            self.view?.hideLoading()
        }
    }
}

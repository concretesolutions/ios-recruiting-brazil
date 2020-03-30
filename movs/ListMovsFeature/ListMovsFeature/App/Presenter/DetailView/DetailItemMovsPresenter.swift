//
//  DetailItemMovsPresenter.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 17/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import GenresFeature
import CommonsModule

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
        
        self.genreService.genre(by: self.itemViewData.genresId) { [weak self] result in
            guard let self = self else { return }
            performUIUpdate {
                switch result {
                case .success(let genres):
                    self.fillUpGenres(with: genres)
                    self.view?.fillUp(with: self.itemViewData)
                    
                case .failure(_):
                    self.view?.fillUp(with: self.itemViewData)
                }
                self.view?.hideLoading()
            }
        }
    }
}

//MARK: - Auxs Functions
extension DetailItemMovsPresenter {
    
    private func fillUpGenres(with genreModels: [GenreModel]) {
        guard genreModels.count > 0 else { return }
        self.itemViewData.genresString = genreModels.reduce("", { (result, genreModel)  in
            return result + genreModel.name + ", "
        })
        self.itemViewData.genresString.removeLast(2) //remove `,` and `space`
    }
}

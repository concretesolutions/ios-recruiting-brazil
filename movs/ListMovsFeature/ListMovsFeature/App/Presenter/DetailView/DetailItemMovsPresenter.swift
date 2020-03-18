//
//  DetailItemMovsPresenter.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 17/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation

class DetailItemMovsPresenter {
    deinit {
        print("TESTE LIFECYCLE DA PRESENTER -- DetailItemMovsPresenter")
    }
    weak var view: DetailItemMovsView?
    var itemViewData: MovsItemViewData
    init(view: DetailItemMovsView, itemViewData: MovsItemViewData) {
        self.view = view
        self.itemViewData = itemViewData
    }
    
}


//MARK: - UI Event - Actions -
extension DetailItemMovsPresenter {
    func loadingView() {
        self.view?.setTitle("Movies")        
    }
}

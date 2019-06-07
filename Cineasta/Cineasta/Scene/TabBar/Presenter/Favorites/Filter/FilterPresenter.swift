//
//  FilterPresenter.swift
//  Cineasta
//
//  Created by Tomaz Correa on 05/06/19.
//  Copyright (c) 2019 TCS. All rights reserved.
//

import Foundation

// MARK: - STRUCT VIEW DATA -
struct FilterViewData {
    var genres = [Genre]()
}

// MARK: - VIEW DELEGATE -
protocol FilterViewDelegate: NSObjectProtocol {
    func showGenres(viewData: FilterViewData)
}

// MARK: - PRESENTER CLASS -
class FilterPresenter {
    
    private weak var viewDelegate: FilterViewDelegate?
    private var viewData = FilterViewData()
    
    init(viewDelegate: FilterViewDelegate) {
        self.viewDelegate = viewDelegate
    }
}

// MARK: - USERDEFAULTS -
extension FilterPresenter {
    func getGenres() {
        guard let result: GenresResult = UserDefaulstHelper.shared.getObject(forKey: Constants.UserDefaultsKey.genres),
            let genres = result.genres else { return }
        self.viewData.genres = genres
        self.viewDelegate?.showGenres(viewData: self.viewData)
    }
}

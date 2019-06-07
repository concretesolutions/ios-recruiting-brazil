//
//  FavoritesPresenter.swift
//  Cineasta
//
//  Created by Tomaz Correa on 01/06/19.
//  Copyright (c) 2019 TCS. All rights reserved.
//

import Foundation

// MARK: - STRUCT VIEW DATA -
struct FavoritesViewData {
    var movies = [MovieViewData]()
}

// MARK: - VIEW DELEGATE -
protocol FavoritesViewDelegate: NSObjectProtocol {
    func showMovies(viewData: FavoritesViewData)
    func showEmptyList()
}

// MARK: - PRESENTER CLASS -
class FavoritesPresenter {
    
    private weak var viewDelegate: FavoritesViewDelegate?
    private var viewData = FavoritesViewData()
    
    init(viewDelegate: FavoritesViewDelegate) {
        self.viewDelegate = viewDelegate
    }
}

// MARK: - USERDEFAULTS -
extension FavoritesPresenter {
    func getMovies() {
        guard let movies: [MovieViewData] = UserDefaulstHelper.shared.getObject(forKey: Constants.UserDefaultsKey.favoriteList),
            !movies.isEmpty else { self.viewDelegate?.showEmptyList(); return }
        self.viewData.movies = movies
        self.viewDelegate?.showMovies(viewData: self.viewData)
    }
}

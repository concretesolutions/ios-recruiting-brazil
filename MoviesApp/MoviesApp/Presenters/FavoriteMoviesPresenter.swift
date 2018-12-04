//
//  FavoriteMoviesPresenter.swift
//  MoviesApp
//
//  Created by Thiago Borges Jordani on 04/12/18.
//  Copyright © 2018 Thiago Borges Jordani. All rights reserved.
//

import Foundation

protocol FavoriteMoviesViewProtocol: NSObjectProtocol {
    func set(movies: [Movie], filtered: Bool)
    func present(filterView: FilterBaseViewController)
}

protocol FilterDelegate {
    func apply(filter: Filter)
}

class FavoriteMoviesPresenter {
    private weak var view: FavoriteMoviesViewProtocol?
    private var movies = [Movie]()
    private var filter = Filter()
    
    func attach(_ presentedView: FavoriteMoviesViewProtocol) {
        self.view = presentedView
    }
    
    func loadData() {
        let favorites = FavoriteHelper.getFavorites()
        movies = favorites.compactMap{Movie(favorite: $0)}
        self.view?.set(movies: filter.filter(movies: movies), filtered: filter.date != nil || filter.genre != nil)
    }
    
    func getFilterView() {
        if let filterVC = FilterBaseViewController.instantiate() {
            filterVC.delegate = self
            filterVC.currentFilter = self.filter
            self.view?.present(filterView: filterVC)
        }
    }
    
    func clearFilter() {
        filter = Filter()
        loadData()
    }
}

extension FavoriteMoviesPresenter: FilterDelegate {
    func apply(filter: Filter) {
        self.filter = filter
        self.view?.set(movies: filter.filter(movies: movies), filtered: filter.date != nil || filter.genre != nil)
    }
}

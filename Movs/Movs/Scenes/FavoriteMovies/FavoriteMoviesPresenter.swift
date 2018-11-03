//
//  FavoriteMoviesPresenter.swift
//  Movs
//
//  Created by Gabriel Reynoso on 21/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import Foundation

protocol FavoriteMoviesPresenterView: ViewProtocol {
    func present(favoriteMovies:[MovieDetail])
    func present(filteredMovies:[MovieDetail])
    func presentEmpty()
}

final class FavoriteMoviesPresenter: MVPBasePresenter {
    
    private let favoritesDAO = try! FavoriesDAO()
    
    private(set) var favoriteMovies:[MovieDetail] = []
    
    var view:FavoriteMoviesPresenterView? {
        return self.baseView as? FavoriteMoviesPresenterView
    }
    
    override func viewWillAppear() {
        self.favoriteMovies = self.favoritesDAO.fetchAll()
        if self.favoriteMovies.count == 0 {
            self.view?.presentEmpty()
        } else {
            self.view?.present(favoriteMovies: self.favoriteMovies)
        }
        super.viewWillAppear()
    }
}

extension FavoriteMoviesPresenter: FavoriteMoviesViewPresenter {
}

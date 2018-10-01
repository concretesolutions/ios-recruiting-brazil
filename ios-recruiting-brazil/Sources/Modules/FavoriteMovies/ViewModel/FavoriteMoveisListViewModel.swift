//
//  FavoriteMoveisListViewModel.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import RxSwift

protocol FavoriteMoveisListViewModelType {
    var favorites: Variable<[MovieModel]> { get }
    
    func fetchFavorites()
    func filterFavorite(titleSearched: String)
    func removeFavorite(index: Int)
}

final class FavoriteMoveisListViewModel: FavoriteMoveisListViewModelType {
    
    private var service: FavoriteMoviesListService
    private var originalFavoriter: [MovieModel] = []
    
    var favorites = Variable<[MovieModel]>([])
    
    init() {
        self.service = FavoriteMoviesListService()
        self.fetchFavorites()
    }
    
    func fetchFavorites() {
        self.favorites.value = self.service.fetchFavoreites() ?? []
        self.originalFavoriter = self.favorites.value
    }
    
    func filterFavorite(titleSearched: String) {
        guard self.originalFavoriter.count > 0 else {
            return
        }
        
        guard titleSearched.count > 0 else {
            self.favorites.value = originalFavoriter
            return
        }
        
        self.favorites.value = self.originalFavoriter.filter({ movie -> Bool in
            return movie.title.contains(titleSearched)
        })
    }
    
    func removeFavorite(index: Int) {
        self.service.remove(movie: self.originalFavoriter[index])
        self.fetchFavorites()
    }
}

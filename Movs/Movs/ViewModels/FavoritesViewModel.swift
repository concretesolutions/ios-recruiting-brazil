//
//  FavoritesViewModel.swift
//  Movs
//
//  Created by Franclin Cabral on 1/20/19.
//  Copyright © 2019 franclin. All rights reserved.
//

import Foundation
import RxSwift

protocol FavoritesViewModelProtocol: BaseViewModelProtocol {
    var dataSource: Variable<[Movie]> { get }
    
    func getMovie(_ index: Int) -> Movie
    func removeFavorited(index: Int)
    func loadData()
}

class FavoritesViewModel: FavoritesViewModelProtocol {
    var dataSource: Variable<[Movie]> = Variable<[Movie]>([])
    
    init() {
        dataSource =  Variable<[Movie]>(self.getFavoriteds())
    }
    
    func loadData() {
        dataSource.value = self.getFavoriteds()
    }
    
    func getFavoriteds() -> [Movie] {
        let dataStore = ManagerCenter.shared.factory.dataStore
        let movies = dataStore.read(Movie.self, matching: nil)
        return movies
    }
    
    func removeFavorited(index: Int) {
        let dataStore = ManagerCenter.shared.factory.dataStore
        let movie = getMovie(index)
        do {
            try dataStore.delete(movie)
            let newMovies = getFavoriteds()
            dataSource = Variable<[Movie]>(newMovies)
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    func getMovie(_ index: Int) -> Movie {
        return dataSource.value[index]
    }
}

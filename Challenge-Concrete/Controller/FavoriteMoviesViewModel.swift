//
//  FavoriteMoviesViewModel.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

class FavoriteMoviesViewModel: MovieViewModel {

    weak var dataSource: MovieDataSource?

    func fetchFavoriteMovies() {
        self.dataSource?.data = CoreDataManager.fetch()
    }
    
    func add(_ favoriteMovie: FavoriteMovie) {
        self.dataSource?.data.append(favoriteMovie)
    }
    
    func remove(_ favoriteMovie: FavoriteMovie) {
        //self.dataSource?.data.first(where: {$0.id == favoriteMovie.id}) 
    }

}

//
//  MoviesListViewModel.swift
//  Movs
//
//  Created by Bruno Barbosa on 27/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import Foundation

class MoviesListViewModel {
    
    private var cellViewModels: [MovieCellViewModel] = []
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func fetchMovies(completion: @escaping ()->()) {
        TMDBMovieService.shared.fectchPopularMovies { (sucess: Bool, error: APIError?, movies: [Movie]) in
            DispatchQueue.main.async {
                self.cellViewModels = movies.map({ MovieCellViewModel(with: $0) })
                completion()
            }
        }
    }
    
    func getViewModelForCell(at indexPath: IndexPath) -> MovieCellViewModel? {
        let index = indexPath.row
        if index < 0 || index > self.numberOfCells {
            return nil
        }
        
        return cellViewModels[index]
    }
}

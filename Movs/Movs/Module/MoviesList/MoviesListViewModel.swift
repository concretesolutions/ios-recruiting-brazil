//
//  MoviesListViewModel.swift
//  Movs
//
//  Created by Bruno Barbosa on 27/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import Foundation

class MoviesListViewModel {
    
    weak var delegate: MoviesListDelegate?
    
    private var cellViewModels: [MovieCellViewModel] = [] {
        didSet {
            self.delegate?.moviesListUpdated()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    private(set) var isLoadingList: Bool = false {
        didSet {
            self.delegate?.toggleLoading(self.isLoadingList)
        }
    }
    
    func fetchMovies() {
        self.isLoadingList = true
        TMDBMovieService.shared.fectchPopularMovies { (error: APIError?, movies: [Movie]) in
            DispatchQueue.main.async {
                if let error = error {
                    self.delegate?.errorFetchingMovies(error: error)
                    return
                }
            
                self.isLoadingList = false
                self.cellViewModels = movies.map({ MovieCellViewModel(with: $0) })
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

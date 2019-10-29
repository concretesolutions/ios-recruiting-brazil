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
    
    var onMovieSelected: ((MovieCellViewModel)->())?
    
    private var cellViewModels: [MovieCellViewModel] = [] {
        didSet {
            self.updateList()
        }
    }
    
    var cellCount: Int {
        return cellViewModels.count
    }
    
    private(set) var isLoadingList: Bool = false {
        didSet {
            self.delegate?.toggleLoading(self.isLoadingList)
        }
    }
    
    private var movieService: MovieServiceProtocol
    
    init(withService movieService: MovieServiceProtocol) {
        self.movieService = movieService
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateList), name: .didUpdateFavoritesList, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func getViewModelForCell(at indexPath: IndexPath) -> MovieCellViewModel? {
        let index = indexPath.row
        if index < 0 || index > self.cellCount {
            return nil
        }
        
        return cellViewModels[index]
    }
    
    func fetchMovies() {
        self.isLoadingList = true
        movieService.fetchPopularMovies { (error: APIError?, movies: [Movie]) in
            DispatchQueue.main.async {
                if let error = error {
                    self.delegate?.errorFetchingMovies(error: error)
                    return
                }
            
                self.isLoadingList = false
                self.cellViewModels = movies.map({ MovieCellViewModel(with: $0, andService: self.movieService) })
            }
        }
    }
    
    func selectMovie(at indexPath: IndexPath) {
        if let cellVM = self.getViewModelForCell(at: indexPath) {
            self.onMovieSelected?(cellVM)
        }
    }
    
    @objc private func updateList() {
        self.delegate?.moviesListUpdated()
    }
}

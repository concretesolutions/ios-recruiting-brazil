//
//  FavoritesListViewModel.swift
//  Movs
//
//  Created by Bruno Barbosa on 28/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import Foundation

class FavoritesListViewModel {
    private var movieService: MovieServiceProtocol
    weak var delegate: FavoritesListDelegate?
    var onMovieSelected: ((FavoriteMovieCellViewModel)->())?
    
    private(set) var cellViewModels: [FavoriteMovieCellViewModel] = [] {
        didSet {
            self.delegate?.favoritesListUpdated()
        }
    }
    
    var cellCount: Int {
        return self.cellViewModels.count
    }
    
    var isLoadingList: Bool = true {
        didSet {
            self.delegate?.toggleLoading(self.isLoadingList)
        }
    }
    
    init(withService service: MovieServiceProtocol) {
        self.movieService = service
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func getViewModelForCell(at indexPath: IndexPath) -> FavoriteMovieCellViewModel? {
        let index = indexPath.row
        if index < 0 || index > self.cellCount {
            return nil
        }
        
        return cellViewModels[index]
    }
    
    func fetchFavorites() {
        self.isLoadingList = true
        self.movieService.fetchFavoriteMovies { (error: APIError?, movies: [Movie]) in
            DispatchQueue.main.async {
                if let error = error {
                    self.delegate?.errorFetchingMovies(error: error)
                    return
                }
            
                self.isLoadingList = false
                self.cellViewModels = movies.map({ FavoriteMovieCellViewModel(with: $0) })
                
                NotificationCenter.default.addObserver(self, selector: #selector(self.updateFavoritesList), name: .didUpdateFavoritesList, object: nil)
            }
        }
    }
    
    @objc private func updateFavoritesList() {
        DispatchQueue.main.async {
            self.cellViewModels = self.movieService.favoriteMovies.map({ FavoriteMovieCellViewModel(with: $0) })
        }
    }
    
    func selectMovie(at indexPath: IndexPath) {
        if let cellVM = self.getViewModelForCell(at: indexPath) {
            self.onMovieSelected?(cellVM)
        }
    }
    
}

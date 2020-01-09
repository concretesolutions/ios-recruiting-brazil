//
//  MovieListViewModel.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 23/12/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import Foundation

class MovieListViewModel {
    
    init() {}
    
    // Closures
    
    var didChangeLoadingState: ((Bool) -> Void)?
    var reloadData: (() -> Void)?
    var openDetailsScreen: ((MovieDetailViewModel) -> Void)?
    
    var noResultsFound: ((String) -> Void)?
    var errorWhileLoadingMovies: ((Error) -> Void)?
    
    // TODO: Change to localizables
    // Texts
    var title: String {
        return "Movies"
    }
    
    private var currentPage = 1 {
        didSet {
            getMovies(page: self.currentPage)
        }
    }
    
    private var cellViewModels = [MovieCellViewModel]()
    
    var numberOfMovies: Int {
        return self.cellViewModels.count
    }
    
    func getViewModel(for indexPath: IndexPath) -> MovieCellViewModel {
        
        return self.cellViewModels[indexPath.row]
        
    }
    
    func didSelect(at indexPath: IndexPath) {
        
        let viewModel = self.cellViewModels[indexPath.row].getDetailViewModel()
        self.openDetailsScreen?(viewModel)
        
    }
    
    private func getMovies(page: Int) {
        
        self.didChangeLoadingState?(true)
        NetworkManager.getPopularMovies(page: page) { [weak self] (result) in
            self?.didChangeLoadingState?(false)
            
            switch result {
            case .failure(let error):
                self?.errorWhileLoadingMovies?(error)
            case .success(let response):
                self?.cellViewModels = response.movies.map {MovieCellViewModel(with: $0)}
                self?.reloadData?()
                
            }
            
        }
        
    }
    
    public func didBind() {
        getMovies(page: self.currentPage)
    }
    
    public func searchMovies(with text: String) {
        self.noResultsFound?("Nenhum resultado encontrado para \(text)")
    }
    
}

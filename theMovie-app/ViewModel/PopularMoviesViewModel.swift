//
//  PopularMoviesViewModel.swift
//  theMovie-app
//
//  Created by Adriel Alves on 26/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import Foundation
protocol PopularMoviesViewModelDelegate:class {
    func didFinishSuccessRequest()
    func didFinishFailureRequest(error: APIError)
}

class PopularMoviesViewModel {
    weak var delegate:PopularMoviesViewModelDelegate?
    
    var theMovieService: TheMovieService
    var movies: [MovieViewModel] = []
    var total: Int = 0
    
    init(theMovieService: TheMovieService = TheMovieServiceImpl()) {
        self.theMovieService = theMovieService
    }
    
    func requestMovies(currentPage: Int) {
        
        theMovieService.getMovies(page: currentPage) { (result) in
            switch result {
            case .failure(let error):
                self.delegate?.didFinishFailureRequest(error: error)
            case .success(let popularMovies):
                self.movies.append(contentsOf: popularMovies.results.map({ MovieViewModel($0) }))
                self.total = popularMovies.totalPages
                self.delegate?.didFinishSuccessRequest()
                
            }
        }
    }
}

//
//  PopularMoviesViewModel.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 10/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import Foundation
import UIKit

protocol PopularMoviesDelegate: UIViewController {
    func reloadData()
}

class PopularMoviesViewModel {
    
    internal var movies: MovieResult?
    
    internal weak var controller: PopularMoviesDelegate?

    internal func setView(_ controller: PopularMoviesDelegate) {
        self.controller = controller
    }
    
    internal func getPopularMovies(reload: Bool = false) {
        
        if reload {
            self.movies = nil
            self.controller?.reloadData()
        }
        
        let currentPage = self.movies?.page ?? 0
        let page = currentPage + 1
        
        
        MovieService.shared.getPopularMovies(page: page) { (result) in
            switch result {
            case .success(let contents, _):
                if self.movies == nil {
                    self.movies = contents
                } else {
                    var movies = self.movies?.results ?? []
                    movies += contents.results ?? []
                    self.movies?.results = movies.unique { $0.id ?? 0 }
                    self.movies?.page = contents.page
                }
            case .failure(let error, _):
                self.controller?.showError(message: error.message())
            }
            
            self.controller?.reloadData()
        }
    }
}

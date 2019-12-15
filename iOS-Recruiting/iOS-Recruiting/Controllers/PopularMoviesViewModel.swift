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
        }
        
        
        MovieService.shared.getPopularMovies(page: 1) { (result) in
            switch result {
            case .success(let contents, _):
                self.movies = contents
                self.controller?.reloadData()
            case .failure(let error, _):
                self.controller?.showError(message: error.message())
            }
        }
    }
}

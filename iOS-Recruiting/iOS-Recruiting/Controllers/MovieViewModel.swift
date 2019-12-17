//
//  PopularMoviesVC.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 17/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import Foundation
import UIKit

protocol MovieDelegate: UIViewController {
    func reloadData()
}

class MovieViewModel {
    
    internal var movie: Movie?
    
    internal weak var controller: MovieDelegate?

    internal func setView(_ controller: MovieDelegate) {
        self.controller = controller
    }
    
    func getMovieDetails() {
        MovieService.shared.getDetails(id: self.movie?.id ?? 0) { (result) in
            switch result {
            case .failure(let error, _):
                self.controller?.showError(message: error.message())
            case .success(let movie, _):
                self.movie = movie
                self.controller?.reloadData()
            }
        }
    }
}

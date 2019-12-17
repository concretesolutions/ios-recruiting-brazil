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
    func showTableError(type: errorType)
}

class PopularMoviesViewModel {
    
    internal var movies: MovieResult?
    
    private(set) var searchTerm: String?
    
    internal var movieList: [Movie]? {
        if let term = self.searchTerm {
            return self.movies?.results?.filter({ (movie) -> Bool in
                return movie.title?.contains(term) ?? false
            })
        }
        
        return self.movies?.results
    }
    
    internal var favourites: [Movie] {
        let cookieName = CookieName.movie.rawValue
        let items = Cookie.shared.getAll(cookieName)
        var response = [Movie]()
        items?.forEach({ (cookie) in
            if let movie = Movie(JSONString: cookie.value) {
                response.append(movie)
            }
        })
        return response
    }
    
    internal weak var controller: PopularMoviesDelegate?

    internal func setView(_ controller: PopularMoviesDelegate) {
        self.controller = controller
    }
    
    internal func resetSearch() {
        self.searchTerm = nil
        self.controller?.reloadData()
    }
    
    internal func search(byName name: String) {
        self.searchTerm = name
        let isEmpty = self.movieList?.isEmpty ?? true
        if isEmpty {
            self.controller?.showTableError(type: .search)
        }
        self.controller?.reloadData()
        
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
                self.controller?.showTableError(type: .none)
            case .failure(let error, _):
                if reload {
                    self.controller?.showTableError(type: .undefined)
                } else {
                    self.controller?.showError(message: error.message())
                }
            }
            
            self.controller?.reloadData()
        }
    }
}

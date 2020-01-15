//
//  MovieCollection.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 10/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import Foundation

protocol MovieCollectionDelegate {
    func reload()
}

class MovieColletion {
    
    var delegate: MovieCollectionDelegate?
    
    private var movies = [Movie]()
    
    var count: Int {
        get {
            return movies.count
        }
    }
    
//    func addMovies(_ movies: [Movie]) {
//        self.movies.append(contentsOf: movies)
//    }
    
    func movie(at index: Int) -> Movie? {
        return movies[safeIndex: index]
    }
    
    func requestMovies() {
        ServiceLayer.request(router: .getMovies) { (result: Result<MoviesResponse, Error>) in
            switch result {
            case .success(let response):
                self.movies.append(contentsOf: response.results)
                self.delegate?.reload()
            case .failure(let error):
                print(error)
            }
        }
    }
}

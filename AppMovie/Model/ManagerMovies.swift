//
//  InitialViewController.swift
//  AppMovie
//
//  Created by Renan Alves on 28/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

class ManagerMovies {
    
    static var shared = ManagerMovies()
    var _movies = [Dictionary<String,Any>]()
    var movies = [Movie]()
    var moviesFavorites = [Movie]()
    
    
    init() {
    }
    
    func setupMovies(pageNumber: Int,completion: @escaping ( [Movie]?) -> ()) {
        MovieDAO.shared.requestMovies(apilink: APILinks.moviesPopularity.value, pageNumber: pageNumber, completion: { (moviesJSON) in
            if let _movies = moviesJSON {
                self._movies.append(contentsOf: _movies)
                self.transformDictionary(moviesJSON: self._movies)
                completion(self.movies)
            } else {
                print("Nothing movies")
                completion(nil)
            }
        })
    }
    
    private func transformDictionary(moviesJSON: [Dictionary<String,Any>]) {
        var arrayMovie = [Movie]()
        for movie in moviesJSON {
            let _movie = Movie(_movieNP: movie)
            if _movie.id != 0 {
                arrayMovie.append(_movie)
            }
        }
        if !arrayMovie.isEmpty {
            self.movies = arrayMovie
        }else {
            print("did not tranform moviesJSON in moviesPlayinNow")
        }
    }
}

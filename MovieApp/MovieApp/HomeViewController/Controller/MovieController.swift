//
//  HomeController.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 07/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import Foundation
protocol MovieControllerDelegate: class {
    func didFinishRequest()
    func finishRefresh()
    func error(type: TypeError)
}

class MovieController {
    
    var arrayMovies: [Movie] = []
    var filteredMovies: [Movie] = []
    var searchActived: Bool = false
    var delegate: MovieControllerDelegate?
    var fetchMore: Bool = true
    var indexPageRequest = 2
    
    func getMovies() {
        if fetchMore {
            ApiManager().getMovies { (movies, error) in
                if !error {
                    if let arraySuccess = movies {
                        self.arrayMovies.append(contentsOf: arraySuccess)
                        self.delegate?.finishRefresh()
                        
                    }
                }else {
                    self.delegate?.error(type: .failureRequest)
                }
                
            }
        }
    }

    func loadMoreMovies() {
        if fetchMore {
            self.fetchMore = false
            ApiManager().loadMoreMovies(page: self.indexPageRequest) { (movies, error) in
                if !error {
                    if let movieList = movies {
                        self.arrayMovies.append(contentsOf: movieList)
                        self.indexPageRequest += 1
                        self.delegate?.didFinishRequest()
                    }
                }else {
                    self.delegate?.error(type: .failureRequest)
                }
                self.fetchMore = true
            }
        }
    }
    
    func getAllGenres() {
           ApiManager().getGenres { (arrayGenre, error) in
               if !error {
                   if let genres = arrayGenre {
                       DataManager().saveGenres(genresToSave: genres)
                   }
               }
           }
       }
    
    func getArrayCount() -> Int {
        return arrayMovies.count
    }
    
    func getArrayFilterCount() -> Int {
        return filteredMovies.count
    }
    
    func getMovieFilter(index: Int) -> Movie {
        return filteredMovies[index]
    }
    
    func getMovie(index: Int) -> Movie {
        return arrayMovies[index]
    }
    
    func setSearchTrue() {
        searchActived = true
    }
    
    func setSearchFalse() {
        searchActived = false
    }
    
    func getSearchActive() -> Bool {
        return searchActived
    }
    
    func filterMovies(name: String) {
        filteredMovies = arrayMovies.filter({ (movie) -> Bool in
            movie.title.lowercased().contains(name.lowercased())
        })
    }

    
}

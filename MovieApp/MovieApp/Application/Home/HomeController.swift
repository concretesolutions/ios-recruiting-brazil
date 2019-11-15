//
//  HomeController.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 07/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import Foundation

protocol HomeControllerDelegate: class {
    func showMovies(movies: [Movie])
    func error(type: TypeError)
}

class HomeController: NSObject {
    
    var movies: [Movie] = []
    var filteredMovies: [Movie] = []
    var searchActived: Bool = false
    private weak var delegate: HomeControllerDelegate?
    var fetchMore: Bool = true
    var indexPageRequest = 1
    
    init(delegate: HomeControllerDelegate) {
        self.delegate = delegate
        super.init()
    }
    
    func getMovies() {
        if fetchMore {
            self.fetchMore = false
            ApiManager().loadMovies(page: self.indexPageRequest) { (movies, error) in
                if let movieList = movies {
                    self.movies.append(contentsOf: movieList)
                    self.indexPageRequest += 1
                    self.delegate?.showMovies(movies: self.movies)
                }
                else {
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
                       GenreDataManager().saveGenres(genresToSave: genres)
                   }
               }
           }
       }
    
    func saveMovie(movie: Movie) {
        let movieManager = MovieDataManager()
       movieManager.loadMovie { (arrayCoreData) in
            let arraySaved = arrayCoreData.filter{$0.id == Int64(movie.id)}
            if arraySaved.count > 0 {
                movieManager.delete(id: arraySaved.first!.objectID) { (success) in
                    if success {
                        print("Removeu")
                    }
                }
            } else {
                movieManager.saveMovie(movieToSave: movie, genres: GenreDataManager().getGenreString(movie: movie))
            }
        }
    }
    
    
    func getArrayCount() -> Int {
        return movies.count
    }

    func filterMovies(text: String) {
        if text.isEmpty {
            delegate?.showMovies(movies: movies)
            fetchMore = true
        } else {
            let movies = self.movies.filter({ (movie) -> Bool in
                (movie.title?.lowercased().contains(text.lowercased()) ?? false)
            })
            delegate?.showMovies(movies: movies)
            fetchMore = false
        }
    }
}

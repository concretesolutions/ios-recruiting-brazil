//
//  FavoriteController.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 07/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import Foundation

protocol FavoriteControllerDelegate {
    func showMovies(movies: [Movie])
}

class FavoriteController {
    
    var movieManager = MovieDataManager()
    var genreDataManager = GenreDataManager()
    var delegate: FavoriteControllerDelegate?
    
    func filterGenresAndYears(genreText: String, yearText: String) {
        
        var genresAndYears: [Movie] = []
        
        genreDataManager.loadGenres { (arrayGenres) in
            movieManager.loadMovie { (arrayMovie) in
                arrayGenres.forEach { (genre) in
                    arrayMovie.forEach { (movie) in
                        movie.genres?.forEach({ (genreID) in
                            if genre.id == Int32(genreID) {
                                if genre.name == genreText {
                                    if transformDateInString(movie: movie) == yearText {
                                        genresAndYears.append(Movie(movie: movie))
                                    }
                                }
                            }
                        })
                    }
                }
            }
        }
        
        delegate?.showMovies(movies: genresAndYears)
    }
    
    func filterGenres(text: String) {
        var genres: [Movie] = []
        
        genreDataManager.loadGenres { (arrayGenres) in
            movieManager.loadMovie { (arrayMovie) in
                arrayGenres.forEach { (genre) in
                    arrayMovie.forEach { (movie) in
                        movie.genres?.forEach({ (genreID) in
                            if genre.id == Int32(genreID) {
                                if genre.name == text {
                                    genres.append(Movie(movie: movie))
                                }
                            }
                        })
                    }
                }
            }
        }
        delegate?.showMovies(movies: genres)
    }
    
    func getYears(text: String) {
        var yearMovies: [Movie] = []
        movieManager.loadMovie { (arrayMovie) in
            arrayMovie.forEach { (movie) in
                if transformDateInString(movie: movie) == text {
                    yearMovies.append(Movie(movie: movie))
                }
            }
        }
        delegate?.showMovies(movies: yearMovies)
    }
    
    func transformDateInString(movie: MovieData) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy"
        
        if let date = dateFormatterGet.date(from: movie.releaseDate ?? "") {
            return dateFormatterPrint.string(from: date)
        }
        return ""
    }
    
    func getMovies() {
        var movies: [Movie] = []
        movieManager.loadMovie { (arrayMovie) in
            arrayMovie.forEach { (movie) in
                movies.append(Movie(movie: movie))
            }
            delegate?.showMovies(movies: movies)
        }
    }
    
    func delete(movie: Movie, completion: (Bool) -> Void) {
        var movies: [MovieData] = []
        movieManager.loadMovie { (moviesData) in
            movies = moviesData.filter({$0.id == Int64(movie.id)})
        }
        if let movieSelected = movies.first {
            movieManager.delete(id: movieSelected.objectID) { (success) in
                if success {
                    completion(true)
                    return
                }
                completion(false)
            }
        }
    }
    
}

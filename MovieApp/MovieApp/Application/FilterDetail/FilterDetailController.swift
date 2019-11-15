//
//  FilterDetailController.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 13/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import Foundation

protocol FilterDetailControllerDelegate: class {
    func updateMovies(genreDate: [String])
}

class FilterDetailController {
    
    var movieManager = MovieDataManager()
    let genreDataManager = GenreDataManager()
    var delegate: FilterDetailControllerDelegate?
    
    func getGenres() {
        var genres:[String] = []
        genreDataManager.loadGenres { (arrayGenres) in
            movieManager.loadMovie { (arrayMovie) in
                arrayGenres.forEach { (genre) in
                    arrayMovie.forEach { (movie) in
                        movie.genres?.forEach({ (genreID) in
                            if genre.id == Int32(genreID) {
                                if !genres.contains(genre.name ?? "") {
                                    genres.append(genre.name ?? "")
                                }
                            }
                        })
                    }
                }
            }
        }
        delegate?.updateMovies(genreDate: genres)
    }
    
    func getYears() {
        var yearMovies:[String] = []
        movieManager.loadMovie { (arrayMovie) in
            arrayMovie.forEach { (movie) in
                if !yearMovies.contains(transformDateInString(movie: movie)) {
                    yearMovies.append(transformDateInString(movie: movie))
                }
            }
        }
        delegate?.updateMovies(genreDate: yearMovies)
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
}


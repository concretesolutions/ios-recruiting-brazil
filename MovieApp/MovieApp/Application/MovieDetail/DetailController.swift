//
//  DetailController.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 07/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//


import Foundation

class DetailController {
    
    var movie: Movie?
    let movieDataManager = MovieDataManager()
    let genreDataManager = GenreDataManager()
    
    func isFavoriteMovieData(movie: MovieData) -> Bool {
         var array:[MovieData]  = []
         movieDataManager.loadMovie { (arrayCoreData) in
             array = arrayCoreData
         }
        let arraySaved = array.filter{$0.id == movie.id}
        return arraySaved.count > 0
     }
     
    
    func saveMovieCoreData(movie: MovieData) {
        movieDataManager.loadMovie { (arrayCoreData) in
            let arraySaved = arrayCoreData.filter{$0.id == movie.id}
            if arraySaved.count > 0 {
                movieDataManager.delete(id: movie.objectID) { (success) in }
            } else {
                movieDataManager.saveMovieCoreData(movie: movie)
            }
        }
    }
    
    func deleteMovieData(movie: MovieData) {
        movieDataManager.delete(id: movie.objectID) { _ in  }
    }
    
    func saveMovie(movie: Movie) {
        movieDataManager.loadMovie { (arrayCoreData) in
            let arraySaved = arrayCoreData.filter{$0.id == Int64(movie.id)}
            if arraySaved.count > 0 {
                movieDataManager.delete(id: arraySaved.first!.objectID) { _ in }
            } else {
                movieDataManager.saveMovie(movieToSave: movie,
                                           genres: genreDataManager.getGenreString(movie: movie))
            }
        }
    }
    
    func isFavorite(movie: Movie) -> Bool {
        var array: [MovieData] = []
        movieDataManager.loadMovie { (arrayCoreData) in
            array = arrayCoreData
        }
        let arraySaved = array.filter{ $0.id == Int64(movie.id) }
        return arraySaved.count > 0
    }
    
    func dataFormatter(movie: Movie?, movieData: MovieData?) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        
        if let movieSelected = movie, let date = dateFormatterGet.date(from: movieSelected.releaseDate ?? "") {
            return dateFormatterPrint.string(from: date)
        } else if let movieSelectedSave = movieData, let date = dateFormatterGet.date(from: movieSelectedSave.releaseDate ?? "") {
            return dateFormatterPrint.string(from: date)
        } else {
            return ""
        }
    }
    
    func getGenre(movie: Movie?) -> String {
        if let movieSelected = movie {
            return genreDataManager.getGenreString(movie: movieSelected)
        }
        return ""
    }
    
}




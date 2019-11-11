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
    let dataManager: DataManager = DataManager()
    
    func isFavoriteMovieSave(movie: MovieSave) -> Bool {
         var array:[MovieSave]  = []
         dataManager.loadMovie { (arrayCoreData) in
             array = arrayCoreData
         }
        let arraySaved = array.filter{$0.id == movie.id}
        return arraySaved.count > 0
     }
     
    
    func saveMovieCoreData(movie: MovieSave) {
        dataManager.loadMovie { (arrayCoreData) in
            let arraySaved = arrayCoreData.filter{$0.id == movie.id}
            if arraySaved.count > 0 {
                dataManager.delete(id: movie.objectID) { (success) in
                    if success {
                        print("Removeu")
                    }
                }
            }else {
                dataManager.saveMovieCoreData(movie: movie)
            }
        }
    }
    
    func deleteMovieSave(movie: MovieSave) {
        dataManager.delete(id: movie.objectID) { (success) in
            if success {
                print("removeu")
            }
        }
    }
    
    func saveMovie(movie: Movie) {
        dataManager.loadMovie { (arrayCoreData) in
            let arraySaved = arrayCoreData.filter{$0.id == Int64(movie.id)}
            if arraySaved.count > 0 {
                dataManager.delete(id: arraySaved.first!.objectID) { (success) in
                    if success {
                        print("Removeu")
                    }
                }
            }else {
                dataManager.saveMovie(movieToSave: movie, genres: dataManager.getGenreString(movie: movie))
            }
        }
    }
    
    func isFavorite(movie: Movie) -> Bool {
        var array:[MovieSave]  = []
        dataManager.loadMovie { (arrayCoreData) in
            array = arrayCoreData
        }
        let arraySaved = array.filter{$0.id == Int64(movie.id)}
        return arraySaved.count > 0
    }
    
    func dataFormatter(movie: Movie?, movieSave: MovieSave?) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        
        if let movieSelected = movie, let date = dateFormatterGet.date(from: movieSelected.releaseDate) {
            return dateFormatterPrint.string(from: date)
        } else if let movieSelectedSave = movieSave, let date = dateFormatterGet.date(from: movieSelectedSave.releaseDate ?? "") {
            return dateFormatterPrint.string(from: date)
        } else {
            return ""
        }
    }
    
    func getGenre(movie: Movie?) -> String {
        if let movieSelected = movie {
            return dataManager.getGenreString(movie: movieSelected)
        }
        return ""
    }
    
}




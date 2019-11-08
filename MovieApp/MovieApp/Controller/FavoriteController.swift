//
//  FavoriteController.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 07/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import Foundation

class FavoriteController {
    
    var arrayMovies: [MovieSave] = []
    var delegate: MovieControllerDelegate?
    var dataManager = DataManager()

    func getMovies() {
        dataManager.loadMovie { (arrayMovie) in
            self.arrayMovies = arrayMovie
        }
    }
    
    func getArrayCount() -> Int {
        return arrayMovies.count
    }
    
    func getMovie(index: Int) -> MovieSave {
        return arrayMovies[index]
    }
    
    func delete(movie: MovieSave, completion: (Bool) -> Void) {
        dataManager.delete(id: movie.objectID) { (success) in
            if success {
                completion(true)
                return
            }
            completion(false)
        }
    }
    
}


protocol FavoritableDelegate {
    func save(movie: Movie)
    func isInCoreData(movie: Movie) -> Bool
}

extension FavoritableDelegate {
    
    func isInCoreData(movie: Movie) -> Bool {
        let dataManager = DataManager()
        var arrayCoreData2:[MovieSave]  = []
        dataManager.loadMovie { (arrayCoreData) in
            arrayCoreData2 = arrayCoreData
        }
        let arraySaved = arrayCoreData2.filter{$0.id == Int64(movie.id)}
        return arraySaved.count > 0
    }
    
    
    func save(movie: Movie) {
        let dataManager = DataManager()
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
}

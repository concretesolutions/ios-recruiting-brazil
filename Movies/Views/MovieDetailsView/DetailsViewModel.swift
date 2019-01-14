//
//  DetailsViewModel.swift
//  Movies
//
//  Created by Matheus Queiroz on 1/10/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import Foundation

class DetailsViewModel {
    let infoParser = Parser.shared
    var controller: DetailsViewController
    let sharedDBManager = DBManager.shared
    
    init(viewController: DetailsViewController){
        controller = viewController
        sharedDBManager.startDB()
    }
    
    func getGenres(forMovie movie: MovieModel) {
        movie.genresIDArray.forEach{ genreID in
            infoParser.genres?.forEach { parsedGenre in
                let parsedGenreID = parsedGenre["id"] as! Int
                if (genreID == parsedGenreID) {
                    let nameRetrieved = parsedGenre["name"] as! String
                    movie.genresStringSet.insert(nameRetrieved)
                }
            }
        }
    }
    
    func addToFavorites(selectedMovie: MovieModel){
        if (sharedDBManager.dbQueue == nil){
            sharedDBManager.startDB()
        }
        sharedDBManager.addToFavorites(movie: selectedMovie)
    }
    
    func verifyIfFavorite(selectedMovie: MovieModel) -> Bool{
        let isFavorite:Bool = sharedDBManager.verifyIfIsFavorite(movie: selectedMovie)
        
        return isFavorite
    }
    
    func remove(fromFavorites movie: MovieModel){
        self.sharedDBManager.removeFromFavorites(movie: movie)
    }
}

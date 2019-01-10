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
    
    
    init(viewController: DetailsViewController){
        controller = viewController
    }
    
    func getGenres(forMovie movie: MovieModel) {
        var genresRetrieved = [String]()
        movie.genresIDArray.forEach{ genreID in
            infoParser.genres?.forEach { parsedGenre in
                let parsedGenreID = parsedGenre["id"] as! Int
                if (genreID == parsedGenreID) {
                    let nameRetrieved = parsedGenre["name"] as! String
                    movie.genresStringArray.insert(nameRetrieved)
                }
            }
        }
    }
    
}

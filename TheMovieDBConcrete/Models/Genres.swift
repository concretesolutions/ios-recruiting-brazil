//
//  Genres.swift
//  TheMovieDBConcrete
//
//  Created by eduardo soares neto on 21/09/18.
//  Copyright © 2018 eduardo soares neto. All rights reserved.
//

import UIKit

class Genres: NSObject {

    var genresArray: [Genre]
    
    override init() {
        genresArray = []
    }
    init(genresInInt genres: [Int]) {
        genresArray = []
        for genre in genres {
            let singleGenre = Genre(genreId: genre)
            genresArray.append(singleGenre)
        }
    }
    init(genresWithDictionary dic:[[String:Any]]) {
        genresArray = []
        for genre in dic {
            let name = genre["name"] as! String
            let genreId = genre["id"] as! Int
            let singleGenre = Genre(genreId: genreId, name: name)
            genresArray.append(singleGenre)
        }
    }
    func getGenreName(withId genreId: Int) -> String {
        var genreName = ""
        for genre in genresArray {
            if genre.genreId == genreId {
                genreName = genre.name
                break
            }
        }
        return genreName
    }
}

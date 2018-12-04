//
//  Movie.swift
//  MoviesApp
//
//  Created by Thiago Borges Jordani on 03/12/18.
//  Copyright © 2018 Thiago Borges Jordani. All rights reserved.
//

import Foundation

struct Movie {
    let movieId: Int
    let title: String
    let posterPath: String
    let genreIds: [Int]
    let overview: String
    let releaseDate: Date//"release_date": "2018-10-03"

    var isFavorite: Bool {
        return FavoriteHelper.isFavorite(movie: self)
    }
    
    init(dictionary: [String: Any]) {
        movieId = Int(safeValue: dictionary["id"])
        title = String(safeValue: dictionary["title"])
        posterPath = String(safeValue: dictionary["poster_path"])
        overview = String(safeValue: dictionary["overview"])
        var genres = [Int]()
        if let ids = dictionary["genre_ids"] as? [Int] {
            for value in ids {
                genres.append(value)
            }
        }
        genreIds = genres
        releaseDate = Date.date(from: String(safeValue: dictionary["release_date"]) + " 12:00", format: "yyyy-MM-dd HH:mm")
    }
    
    init(favorite: FavoriteMovie) {
        movieId = Int(favorite.id)
        title = String(safeValue: favorite.title)
        posterPath = String(safeValue: favorite.posterPath)//favorite.posterPath ??
        genreIds = String(safeValue: favorite.genreIds).split(separator: ",").compactMap{Int($0)}
        overview = String(safeValue: favorite.overview)
        releaseDate = favorite.releaseDate ?? Date()
    }
}

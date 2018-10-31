//
//  FavouriteMovie.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 30/10/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import RealmSwift

@objcMembers class FavoriteMovie: Object {
    dynamic var id = 0
    dynamic var imageUrl: String = ""
    dynamic var genres: String = ""
    dynamic var overview: String = ""
    dynamic var title: String = ""
    dynamic var releaseDate: String = ""
    
    convenience init(movie: Movie) {
        self.init()
        self.id = movie.id
        self.imageUrl = movie.posterPath ?? ""
        self.overview = movie.overview
        self.title = movie.title
        let calendar = Calendar.current
        if let date = movie.releaseDate {
            let year = calendar.component(.year, from: date)
            self.releaseDate = "\(year)"
        }
        let genres = movie.genreIDS.map { (id) -> String in
            return Genre.fetchedGenres[id] ?? "Uknown"
        }
        let genresString = genres.joined(separator: ", ")
        self.genres = genresString
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

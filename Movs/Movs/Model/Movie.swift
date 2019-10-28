//
//  Movie.swift
//  Movs
//
//  Created by Bruno Barbosa on 26/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import Foundation

class Movie {
    let id: UUID
    let title: String
    let posterPath: String
    let releaseDate: Date?
    let genreIds: [Int]
    let overview: String
    let isFavorite: Bool
    
    init(withTitle title: String, andPoster posterPath: String, andReleaseDate dateStr: String, andGenreIds genreIds: [Int], andOverview overview: String, isFavorite: Bool = false) {
        self.id = UUID()
        self.title = title
        self.posterPath = posterPath
        
        let dateFormartter = DateFormatter()
        dateFormartter.dateFormat = "yyyy-MM-dd"
        self.releaseDate = dateFormartter.date(from: dateStr)
        
        self.genreIds = genreIds
        self.overview = overview
        self.isFavorite = isFavorite
    }
}

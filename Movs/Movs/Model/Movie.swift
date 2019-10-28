//
//  Movie.swift
//  Movs
//
//  Created by Bruno Barbosa on 26/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import Foundation

class Movie: Codable {
    let id: Int
    let title: String
    let posterPath: String
    let releaseDateStr: String
    var releaseDate: Date? {
        let dateFormartter = DateFormatter()
        dateFormartter.dateFormat = "yyyy-MM-dd"
        return dateFormartter.date(from: self.releaseDateStr)
    }
    let genreIds: [Int]
    let overview: String
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case releaseDateStr = "release_date"
        case genreIds = "genre_ids"
        case overview
    }
}

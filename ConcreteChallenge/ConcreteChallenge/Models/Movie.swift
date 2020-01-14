//
//  Movie.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 10/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let title: String
    let overview: String
    let releaseDate: String
    let voteAverage: Double
    let genreIDs: [Int]
    
    private let posterPath: String?
    
    var posterURL: URL {
        return URL(safeString: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")
    }
    
    var releaseYear: String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let newDate = dateFormatter.date(from: releaseDate) else { return "???" }
        
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: newDate)
        
        return "\(year)"
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case genreIDs = "genre_ids"
    }
}

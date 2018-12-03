//
//  Movie.swift
//  MoviesC
//
//  Created by Isabel Lima on 02/12/18.
//  Copyright © 2018 Isabel Lima. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let title: String
    let posterPath: String
    let genreIds: [Int]
    let releaseDate: String
    var isFavorite: Bool? = false
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
        case releaseDate = "release_date"
    }
    
    func posterUrl() -> URL {
        guard let configuration = APISettings.shared.configuration else {
            return URL(string: "https://image.tmdb.org/t/p/w500/")!.appendingPathComponent(posterPath)
        }
        
        guard let baseImageURL = URL(string: configuration.images.baseURL) else {
            //TODO: Show error screen
            fatalError("Invalid base URL supplied by API")
        }
        
        var imageSize = ""
        if configuration.images.posterSizes.contains("w500") {
            imageSize = "w300"
        } else {
            imageSize = configuration.images.posterSizes.first ?? "w300"
        }
        let url = baseImageURL.appendingPathComponent(imageSize).appendingPathComponent(posterPath)
        
        return url
        
    }
    
}

extension Movie: Equatable {
    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
}


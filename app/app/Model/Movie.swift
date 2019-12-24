//
//  Movie.swift
//  app
//
//  Created by rfl3 on 23/12/19.
//  Copyright © 2019 Renan Freitas. All rights reserved.
//

import Foundation

struct Movie {
    
    var posterURL: URL?
    var backdropURL: URL?
    var title: String
    var genreIds: [Int]
    var id: Int
    var description: String
    var release: Date?
    var favorite: Bool
    
}

extension Movie: Decodable {
    
    // MARK: - Hashing keys
    enum CodingKeys: String, CodingKey {
        case posterURL = "poster_path"
        case backdropURL = "backdrop_path"
        case title
        case genreIds = "genre_ids"
        case id
        case description = "overview"
        case release = "release_date"
    }
    
    // MARK: - Decode
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let posterPath = try container.decodeIfPresent(String.self, forKey: .posterURL) ?? ""
        let posterURL: URL?
        if posterPath == "" {
            posterURL = nil
        } else {
            posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
        }
        
        let backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropURL) ?? ""
        let backdropURL: URL?
        if backdropPath == "" {
            backdropURL = nil
        } else {
            backdropURL = URL(string: "https://image.tmdb.org/t/p/w780\(backdropPath)")
        }
        
        let title = try container.decode(String.self, forKey: .title)
        let genreIds = try container.decode([Int].self, forKey: .genreIds)
        let id = try container.decode(Int.self, forKey: .id)
        let description = try container.decode(String.self, forKey: .description)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = try container.decode(String.self, forKey: .release)
        let release = dateFormatter.date(from: date)
        
        let fav: Bool
        if let favorite = try? CoreDataService.shared.isFavorite(id) {
            fav = favorite
        } else {
            fav = false
        }
        
        self.init(posterURL: posterURL,
                  backdropURL: backdropURL,
                  title: title,
                  genreIds: genreIds,
                  id: id,
                  description: description,
                  release: release,
                  favorite: fav)
    }
}

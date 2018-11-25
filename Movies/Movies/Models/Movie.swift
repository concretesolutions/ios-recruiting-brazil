//
//  Movie.swift
//  Movies
//
//  Created by Renan Germano on 12/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

class Movie: Decodable {
    
    // MARK: - Properties
    
    var id: Int
    var title: String
    var posterPath: String
    var year: Int
    var genres: [Genre]
    var overview: String
    var posterImage: UIImage?
    var isFavorite: Bool
    
    enum MovieKeys: String, CodingKey {
        case Id = "id"
        case Title = "title"
        case PosterPath = "poster_path"
        case ReleaseDate = "release_date"
        case GenreIds = "genre_ids"
        case Overview = "overview"
    }
    
    // MARK: - Initializers
    init(id: Int, title: String, posterPath: String = "default", year: Int, genres: [Genre], overview: String, isFavorite: Bool = false) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.year = year
        self.genres = genres
        self.overview = overview
        self.isFavorite = isFavorite
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieKeys.self)
        
        let id: Int = try container.decode(Int.self, forKey: .Id)
        let title: String = try container.decode(String.self, forKey: .Title)
        let posterPath: String = (try? container.decode(String.self, forKey: .PosterPath)) ?? "default"
        let releaseDate: String = try container.decode(String.self, forKey: .ReleaseDate)
        let genreIds: [Int] = try container.decode([Int].self, forKey: .GenreIds)
        let overview: String = try container.decode(String.self, forKey: .Overview)
        let year: Int = Int(releaseDate.split(separator: "-").first ?? "0000") ?? 0000
        let genres = GenreDataManager.readGenresByIds(genreIds)
        let isFavorite = MovieDataManager.isFavoriteMovie(id: id)
        self.init(id: id, title: title, posterPath: posterPath, year: year, genres: genres, overview: overview, isFavorite: isFavorite)
    }
    
    
}

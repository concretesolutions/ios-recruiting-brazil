//
//  PopularMovies.swift
//  Movs Challenge Project
//
//  Created by Jezreel Barbosa on 15/01/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

class PopularMoviePage: Decodable, Hashable {
    // Static Properties
    // Static Methods
    
    static func == (lhs: PopularMoviePage, rhs: PopularMoviePage) -> Bool {
        return lhs.page == rhs.page
    }
    // Public Types
    // Public Properties
    
    let page: Int
    let totalResults: Int
    let totalPages: Int
    
    let movies: [Movie]
    
    // Public Methods
    
    func hash(into hasher: inout Hasher) {
        
    }
    // Initialisation/Lifecycle Methods
    // Override Methods
    // Private Types
    
    private enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
    }
    
    // Private Properties
    // Private Methods
}

class Movie: Decodable {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    
    let popularity: Double
    let id: Int
    let video: Bool
    let voteCount: Int
    let voteAverage: Double
    let title: String
    let releaseDate: Date
    let originalLanguage: String
    let originalTitle: String
    let genreIds: [Int]
    let backdropPath: String?
    let adult: Bool
    let overview: String
    let posterPath: String?
    
    var posterImage: UIImage? {
        if privatePosterImage == nil {
            fetchImage()
        }
        return privatePosterImage
    }
    
    // Public Methods
    // Initialisation/Lifecycle Methods
    // Override Methods
    // Private Types
    
    private enum CodingKeys: String, CodingKey {
        case popularity
        case id
        case video
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case title
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIds = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult
        case overview
        case posterPath = "poster_path"
    }
    
    // Private Properties
    
    private var privatePosterImage: UIImage? = nil
    
    // Private Methods
    
    private func fetchImage() {
        guard let path = self.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w342" + path) else { return }
        let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil, let image = UIImage(data: data) else { return }
            self.privatePosterImage = image
        }
        task.resume()
    }
}

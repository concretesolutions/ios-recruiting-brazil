//
//  Movie.swift
//  Movs Challenge Project
//
//  Created by Jezreel Barbosa on 16/01/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

class Movie: Decodable {
    // Static Properties
    
    static let didDownloadPosterImageNN = Notification.Name(rawValue: "com.concrete.Movs-Challenge-Project.Movie.didDownloadPosterImageNN")
    
    // Static Methods
    // Public Types
    // Public Properties
    
    let id: Int
    let title: String
    let releaseDate: Date
    let genreIds: [Int]
    let backdropPath: String?
    let posterPath: String?
    
    var posterImage: UIImage? {
        if privatePosterImage == nil {
            fetchImage()
        }
        return privatePosterImage
    }
    
    // Public Methods
    // Initialisation/Lifecycle Methods
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        let dateString = try container.decode(String.self, forKey: .releaseDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        releaseDate = dateFormatter.date(from: dateString)!
        genreIds = try container.decode([Int].self, forKey: .genreIds)
        backdropPath = try container.decode(String?.self, forKey: .backdropPath)
        posterPath = try container.decode(String?.self, forKey: .posterPath)
    }
    
    // Override Methods
    // Private Types
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case backdropPath = "backdrop_path"
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
            NotificationCenter.default.post(name: Movie.didDownloadPosterImageNN, object: self)
        }
        task.resume()
    }
}

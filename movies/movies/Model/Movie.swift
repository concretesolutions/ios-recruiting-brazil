//
//  Movie.swift
//  movies
//
//  Created by Jacqueline Alves on 01/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation

public struct MovieDTO: Codable {
    public let id: Int
    public let title: String
    public let posterPath: String?
    public let overview: String
    public let releaseDate: Date?
    public let genreIds: [Int]?
    public let genres: [Genre]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath
        case overview
        case releaseDate
        case genreIds
        case genres
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = (try container.decodeIfPresent(Int.self, forKey: .id)) ?? 0
        self.title = (try container.decodeIfPresent(String.self, forKey: .title)) ?? "Title"
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        self.overview = (try container.decodeIfPresent(String.self, forKey: .overview)) ?? ""
        self.genreIds = try container.decodeIfPresent([Int].self, forKey: .genreIds)
        self.genres = try container.decodeIfPresent([Genre].self, forKey: .genres)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateString = (try container.decodeIfPresent(String.self, forKey: .releaseDate)) ?? ""
        self.releaseDate = dateFormatter.date(from: dateString)
    }
}

public struct Movie: Codable {
    public let id: Int
    public let title: String
    public let posterPath: String?
    public let overview: String
    public let releaseDate: Date?
    public let genreIds: [Int]?
    public var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    init(_ dto: MovieDTO) {
        self.id = dto.id
        self.title = dto.title
        self.posterPath = dto.posterPath
        self.overview = dto.overview
        self.releaseDate = dto.releaseDate
        
        if let genres = dto.genres {
            self.genreIds = genres.map { $0.id }
        } else {
            self.genreIds = dto.genreIds
        }
    }
    
    init(id: Int, title: String, posterPath: String?, overview: String, releaseDate: Date, genreIds: [Int], favorite: Bool = false) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.overview = overview
        self.releaseDate = releaseDate
        self.genreIds = genreIds
    }
}

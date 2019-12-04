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
    public let releaseDate: Date
    public let genreIds: [Int]?
}

public struct Movie: Codable {
    public let id: Int
    public let title: String
    public let posterPath: String?
    public let overview: String
    public let releaseDate: Date
    public let genreIds: [Int]?
    public var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    public var favorite: Bool
    
    init(_ dto: MovieDTO) {
        self.id = dto.id
        self.title = dto.title
        self.posterPath = dto.posterPath
        self.overview = dto.overview
        self.releaseDate = dto.releaseDate
        self.genreIds = dto.genreIds
        self.favorite = false
    }
    
    init(id: Int, title: String, posterPath: String?, overview: String, releaseDate: Date, genreIds: [Int], favorite: Bool = false) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.overview = overview
        self.releaseDate = releaseDate
        self.genreIds = genreIds
        self.favorite = favorite
    }
}

//
//  Movie.swift
//  movies
//
//  Created by Jacqueline Alves on 01/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation

public struct Movie: Codable {
    public let id: Int
    public let title: String
    public let posterPath: String?
    public let overview: String
    public let releaseDate: Date
    public let genres: [Genre]?
    public var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    public var favorite: Bool = false
}

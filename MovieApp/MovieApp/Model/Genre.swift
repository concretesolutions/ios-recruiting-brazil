//
//  Genre.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 07/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import Foundation

// MARK: - Movie
struct GenresResult: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

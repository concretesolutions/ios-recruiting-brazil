//
//  MovieResponse.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 19/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

struct MovieResponse: Decodable {
    var page: Int
    var results: [Movie]
}

//
//  MoviesResponse.swift
//  movies
//
//  Created by Jacqueline Alves on 01/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

public struct MoviesResponse: Codable {
    public let page: Int
    public let totalResults: Int
    public let totalPages: Int
    public let results: [Movie]
}

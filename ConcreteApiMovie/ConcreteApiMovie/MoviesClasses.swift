//
//  MoviesClasses.swift
//  ConcreteApiMovie
//
//  Created by Israel3D on 18/09/2018.
//  Copyright © 2018 Israel3D. All rights reserved.
//

import Foundation

struct MovieInfo : Codable {
    let page: Int
    let total_pages: Int
    let results: [MoviesResults]
}

struct MoviesResults : Codable {
    let id: Int
    let title: String
    let overview: String
    let release_date: String
    let poster_path: String
}

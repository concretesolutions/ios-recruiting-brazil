//
//  ResultsDecodable.swift
//  ConcreteChallenge
//
//  Created by Thiago  Wlasenko Nicolau on 30/10/18.
//  Copyright © 2018 Thiago  Wlasenko Nicolau. All rights reserved.
//

import Foundation

struct PopularMovies: Decodable {
    var page: Int?
    var total_results: Int?
    var total_pages: Int?
    var results: [MovieJSON]?
}

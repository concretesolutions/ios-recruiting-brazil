//
//  Result.swift
//  ConcreteTheMovieDB
//
//  Created by Guilherme Gatto on 13/11/18.
//  Copyright © 2018 Guilherme Gatto. All rights reserved.
//

import Foundation

struct Result: DataProtocol {
    var results: [Movie]
    var page: Int
    var total_results: Int
    var dates: Dates
    var total_pages: Int
}

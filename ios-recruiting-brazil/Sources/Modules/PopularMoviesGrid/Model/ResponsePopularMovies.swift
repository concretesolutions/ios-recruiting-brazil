//
//  ResponsePopularMovies.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import Mapper

struct ResponsePopularMovies: Mappable {
    var page: Int
    var totalResult: Int
    var totalPage: Int
    var results: [MovieModel]
    
    init(map: Mapper) throws {
        try page = map.from("page")
        try totalResult = map.from("total_results")
        try totalPage = map.from("total_pages")
        try results = map.from("results")
    }
}

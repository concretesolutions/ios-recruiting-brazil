//
//  Genre.swift
//  ShitMov
//
//  Created by Miguel Nery on 23/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

struct Genre: Decodable {
    let id: Int
    let name: String
}

extension Genre {
    static var genres = [Genre]()
    
    static func genres(forIds ids: [Int]) -> [Genre] {
        var results = [Genre]()
        for id in ids {
            results.append(contentsOf: genres.filter { $0.id == id })
        }
        return results
    }
}

struct GenreResults: Decodable {
    let genres: [Genre]
}

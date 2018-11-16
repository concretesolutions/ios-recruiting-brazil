//
//  Movie.swift
//  ConcreteTMDb
//
//  Created by Pedro Del Rio Ortiz on 15/11/18.
//  Copyright © 2018 Pedro Ortiz. All rights reserved.
//

import Foundation

class Movie: Decodable {
    
    // MARK: - Properties
    let title: String
    let overview: String
    let date: String
    
    // MARK: - Decodable keys
    
    enum MovieDecodableKeys: String, CodingKey {
        case title
        case overview
        case date = "release_date"
    }
    
    // MARK: - Inits
    
    init(title: String, overview: String, date: String) {
        self.title = title
        self.overview = overview
        self.date = date
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieDecodableKeys.self)
        
        let title: String = try container.decode(String.self, forKey: .title)
        let overview: String = try container.decode(String.self, forKey: .overview)
        let date: String = try container.decode(String.self, forKey: .date)
     
        self.init(title: title, overview: overview, date: date)
    }
}

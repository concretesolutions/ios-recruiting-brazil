//
//  Genres.swift
//  Movs Challenge Project
//
//  Created by Jezreel Barbosa on 17/01/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

class Genres: Decodable {
    // Static Properties
    
    static private(set) var list: [Int: String] = [:]
    
    // Static Methods
    // Public Types
    // Public Properties
    
    private var genres: [Genre]
    
    // Public Methods
    // Initialisation/Lifecycle Methods
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        genres = try container.decode([Genre].self, forKey: .genres)
        genres.forEach { (genre) in
            Genres.list[genre.id] = genre.name
        }
        genres = []
    }
    
    // Override Methods
    // Private Types
    
    private enum CodingKeys: String, CodingKey {
        case genres = "genres"
    }
    
    private class Genre: Decodable {
        let id: Int
        let name: String
    }
    
    // Private Properties
    // Private Methods
}

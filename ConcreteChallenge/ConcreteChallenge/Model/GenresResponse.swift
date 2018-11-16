//
//  GenresResponse.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 15/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import Foundation

class GenresResponse: Decodable {
    // MARK: - Properties
    let genres: [Genre]
    
    // MARK: - Decodable Keys
    enum GenresResponseDecodableKey: String, CodingKey {
        case genres = "genres"
    }
    
    // MARK - Inits
    init(genres: [Genre]) {
        self.genres = genres
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GenresResponseDecodableKey.self)
        
        let genres: [Genre] = try container.decode([Genre].self, forKey: .genres)
        
        self.init(genres: genres)
    }
}

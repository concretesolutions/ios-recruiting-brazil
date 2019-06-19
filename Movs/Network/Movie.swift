//
//  Movie.swift
//  Movs
//
//  Created by Filipe on 18/06/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let title: String
    let id: Int
    let posterImage: String
    
    enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case id
        case posterImage = "poster_path"
    }
    
    init(title: String, id: Int, posterImage: String) {
        self.title = title
        self.id = id
        self.posterImage = posterImage
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let title = try container.decode(String.self, forKey: .title)
        let id = try container.decode(Int.self, forKey: .id)
        let posterImage = try container.decode(String.self, forKey: .posterImage)
        self.init(title: title, id: id, posterImage: posterImage)
    }
    
}

//
//  Movie.swift
//  Movs
//
//  Created by Filipe on 18/06/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import Foundation
import UIKit

struct Movie: Decodable {
    let title: String
    let id: Int
    let posterUrl: String
    
    enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case id
        case posterUrl = "poster_path"
    }
    
    init(title: String, id: Int, posterUrl: String) {
        self.title = title
        self.id = id
        self.posterUrl = posterUrl
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let title = try container.decode(String.self, forKey: .title)
        let id = try container.decode(Int.self, forKey: .id)
        let posterUrl = try container.decode(String.self, forKey: .posterUrl)
        self.init(title: title, id: id, posterUrl: posterUrl)
    }
    
}

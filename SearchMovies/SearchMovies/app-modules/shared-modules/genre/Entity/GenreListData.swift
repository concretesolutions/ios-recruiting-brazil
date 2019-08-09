//
//  GenreListData.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 09/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

struct GenreListData {
    var genres:[GenreData]
    
    init(genres:[GenreData]) {
        self.genres = genres
    }
}


extension GenreListData : Decodable {
    enum CodingKeys: String, CodingKey {
        case genres
    }
    
    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let genresDecodable = try container.decode([GenreData].self, forKey: .genres)
        self.init(genres:genresDecodable)
    }
}

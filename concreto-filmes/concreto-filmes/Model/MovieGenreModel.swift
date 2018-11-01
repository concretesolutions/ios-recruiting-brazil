//
//  MovieGenreModel.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 26/10/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import Foundation
import RealmSwift

struct GenreApiResponse {
    let genres: [Genre]
}

extension GenreApiResponse: Decodable {

    enum GenreApiResponseCodingKeys: String, CodingKey {
        case genres
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GenreApiResponseCodingKeys.self)

        genres = try container.decode([Genre].self, forKey: .genres)
    }
}

class Genre: Decodable {
    let id: Int
    let name: String
    static var fetchedGenres: [Int: String] = [:]

    enum GenreCodingKeys: String, CodingKey {
        case id
        case name
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GenreCodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
}

//
//  GenreDTO.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 03/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

struct GenreWrapperDTO: Decodable {
    let genres: [GenreDTO]
}

struct GenreDTO: Decodable {
    let id: Int
    let name: String
}

extension GenreDTO: Equatable {
    static func == (lhs: GenreDTO, rhs: GenreDTO) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}

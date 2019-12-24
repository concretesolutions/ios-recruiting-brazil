//
//  Genre.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 23/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

class Genre {

    // MARK: - Variable

    let id: Int
    let name: String

    // MARK: - Initializers

    init(fromDTO dto: GenreDTO) {
        self.id = dto.id
        self.name = dto.name
    }
}

extension Genre: CustomStringConvertible {
    var description: String {
        "Genre (" + "id: \(self.id), " + "name \(String(describing: self.name))" + ")"
    }
}

extension Genre: Equatable {
    static func == (lhs: Genre, rhs: Genre) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}

extension Genre: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

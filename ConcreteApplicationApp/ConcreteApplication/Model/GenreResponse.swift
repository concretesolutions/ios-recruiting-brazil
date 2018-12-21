//
//  GenreResponse.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 20/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import Foundation

struct GenreResponse{
    var genres: [Genre]
}

extension GenreResponse: Codable{
    enum CodingKeys: String, CodingKey{
        case genres
    }
}

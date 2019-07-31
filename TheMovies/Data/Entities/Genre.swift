//
//  Genre.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/28/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Foundation


import UIKit

/// Estrutura utilizada para mapear resposta da requisição de generos
struct GenresResponse: Codable {
    public let genres: [Genre]
}

struct Genre: Codable, Hashable {
    let id: Int
    let name: String
}


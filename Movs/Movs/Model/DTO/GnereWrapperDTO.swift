//
//  GenreWrapperDTO.swift
//  Movs
//
//  Created by Lucca Ferreira on 17/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Foundation

struct GenreWrapperDTO: Decodable {
    private(set) var genres: [GenreDTO]
}

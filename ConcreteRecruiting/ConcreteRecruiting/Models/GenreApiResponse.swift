//
//  GenreApiResponse.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 08/01/20.
//  Copyright © 2020 Alysson Moreira. All rights reserved.
//

import Foundation

struct GenreApiResponse: Decodable {
    let genres: [Genre]
}

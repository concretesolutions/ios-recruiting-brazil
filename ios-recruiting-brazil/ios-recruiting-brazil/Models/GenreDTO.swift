//
//  GenreDTO.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 15/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import Foundation
struct GenreDTO: Codable {
    let name: String
    let genreID: Int

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case genreID = "id"
    }
}

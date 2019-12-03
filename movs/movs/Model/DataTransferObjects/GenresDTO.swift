//
//  GenresDTO.swift
//  movs
//
//  Created by Emerson Victor on 03/12/19.
//  Copyright © 2019 emer. All rights reserved.
//
// swiftlint:disable identifier_name

import Foundation

struct GenresDTO: Codable {
    let genres: [GenreDTO]
}

struct GenreDTO: Codable {
    let id: Int
    let name: String
}

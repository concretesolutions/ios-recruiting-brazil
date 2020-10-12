//
//  GenresDTO.swift
//  Movs
//
//  Created by Joao Lucas on 11/10/20.
//

import Foundation

struct GenresDTO: Decodable {
    let genres: [Genre]
    
    static var shared: GenresDTO?
}

struct Genre: Decodable {
    var id: Int
    let name: String
}

//
//  ImagesDTO.swift
//  Movs
//
//  Created by Joao Lucas on 19/10/20.
//

import Foundation

struct ImagesDTO: Decodable {
    let posters: [ResultImageDTO]
}

struct ResultImageDTO: Decodable {
    let file_path: String
}

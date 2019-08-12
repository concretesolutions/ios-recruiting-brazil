//
//  GenreParser.swift
//  Movs
//
//  Created by Henrique Campos de Freitas on 12/08/19.
//  Copyright © 2019 Henrique Campos de Freitas. All rights reserved.
//

import Foundation

class GenreParser {
    class DecodableGenre: Decodable {
        let id: Int
        let name: String
    }
    class DecodableGenres: Decodable {
        let genres: Array<DecodableGenre>
    }
    
    static func parseAll(from data: Data) -> Array<GenreObject> {
        var genres: Array<GenreObject> = []
        
        do {
            let decGenres = try JSONDecoder().decode(DecodableGenres.self, from: data)
            for decGenre in decGenres.genres {
                genres.append(GenreObject(id: decGenre.id, name: decGenre.name))
            }
        } catch let error {
            print(error)
        }
        
        return genres
    }
}

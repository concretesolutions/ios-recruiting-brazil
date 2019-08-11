//
//  MovieParser.swift
//  Movs
//
//  Created by Henrique Campos de Freitas on 09/08/19.
//  Copyright © 2019 Henrique Campos de Freitas. All rights reserved.
//

import Foundation

class MovieParser {
    class DecodableMovie: Decodable {
        let id: Int
        let title: String
        let poster_path: String
        let release_date: String
    }
    class DecodableMovies: Decodable {
        let results: Array<DecodableMovie>
    }
    
    static func parseAll(from data: Data) -> Array<MovieObject> {
        var movies: Array<MovieObject> = []
        
        do {
            let decMovies = try JSONDecoder().decode(DecodableMovies.self, from: data)
            for decMovie in decMovies.results {
                movies.append(MovieObject(id: decMovie.id, title: decMovie.title, posterPath: decMovie.poster_path))
            }
        } catch let error {
            print(error)
        }
        
        return movies
    }
}

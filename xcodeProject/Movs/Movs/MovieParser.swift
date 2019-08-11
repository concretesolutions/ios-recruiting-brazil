//
//  MovieParser.swift
//  Movs
//
//  Created by Henrique Campos de Freitas on 09/08/19.
//  Copyright © 2019 Henrique Campos de Freitas. All rights reserved.
//

import Foundation

class MovieParser {
    private static let releaseDateFormat = "yyyy-MM-dd"
    
    class DecodableMovie: Decodable {
        let id: Int
        let title: String
        let poster_path: String
        let release_date: String?
        let overview: String?
    }
    class DecodableMovies: Decodable {
        let results: Array<DecodableMovie>
    }
    
    static func parseAll(from data: Data) -> Array<MovieObject> {
        var movies: Array<MovieObject> = []
        
        let releaseDateFormatter = DateFormatter()
        releaseDateFormatter.dateFormat = releaseDateFormat
        
        do {
            let decMovies = try JSONDecoder().decode(DecodableMovies.self, from: data)
            for decMovie in decMovies.results {
                let overview = decMovie.overview ?? ""
                if let release = releaseDateFormatter.date(from: decMovie.release_date ?? "") {
                    movies.append(MovieObject(id: decMovie.id, title: decMovie.title, posterPath: decMovie.poster_path, release: release, overview: overview))
                } else {
                    print("Invalid date for \(decMovie.id): \(decMovie.release_date ?? "nil value")")
                }
            }
        } catch let error {
            print(error)
        }
        
        return movies
    }
}

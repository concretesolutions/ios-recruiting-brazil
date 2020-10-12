//
//  Constants.swift
//  Movs
//
//  Created by Joao Lucas on 09/10/20.
//

import Foundation

class Constants {
    static var pathPhoto: String {
        return "https://image.tmdb.org/t/p/w500/"
    }
    
    static func getGenresString(movies: ResultMoviesDTO) -> String? {
        let genres = GenresDTO.shared?.genres
            .filter({ genre in movies.genre_ids.contains(genre.id) })
            .map({ genre in genre.name })
            .joined(separator: ", ")
    
            return genres
    }
    
    static func getGenresInt(movies: ResultMoviesDTO) -> [Int]? {
        let genres = GenresDTO.shared?.genres
            .filter({ genre in movies.genre_ids.contains(genre.id) })
            .map({ $0.id })
        
        return genres
    }
    
    static func getYear(movies: ResultMoviesDTO) -> String{
        if let year = movies.release_date.split(separator: "-").first{
            return String(year)
        }
        
        return ""
    }
}

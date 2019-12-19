//
//  DTODecoder.swift
//  Movs
//
//  Created by Gabriel D'Luca on 18/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation

final class DTODecoder {
    func decodeGenres(from data: Data) -> [GenreDTO] {
        do {
            let decodedData = try JSONDecoder().decode(GenresDTO.self, from: data)
            return decodedData.genres
        } catch {
            fatalError("Failed to decode GenresDTO from data.")
        }
    }
    
    func decodePopularMovies(from data: Data) -> [MovieDTO] {
        do {
            let popularMovies = try JSONDecoder().decode(PopularMoviesDTO.self, from: data)
            return popularMovies.results
        } catch {
            fatalError("Failed to decode PopularMoviesDTO from data.")
        }
    }
}

//
//  GenreMemoryRepository.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/28/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Foundation

protocol GenreMemoryRepositoryProtocol {
    func cache(genres: [Genre])
    func getGenre(with id: Int) -> Genre?
    func getAll() -> [Genre]
}


final class GenreMemoryRepository: GenreMemoryRepositoryProtocol {
    private var genres = [Genre]()
    
    func cache(genres: [Genre]) {
        self.genres.append(contentsOf: genres)
    }
    
    func getGenre(with id: Int) -> Genre?{
        return genres.filter({
            genre in
            return genre.id == id
        }).first
    }
    
    func getAll() -> [Genre] {
        return genres
    }
}

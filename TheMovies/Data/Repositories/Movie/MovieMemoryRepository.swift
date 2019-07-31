//
//  MemoryRepository.swift
//  MyMovies
//
//  Created by Matheus Bispo on 7/27/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Foundation

protocol MovieMemoryRepositoryProtocol {
    func cache(page: Int, movies: [Movie])
    func getAllMovies() -> [Movie]
    func getAllFavoriteMovies() -> [Movie]
    func getMovies(from page: Int) -> [Movie]
    func getMovie(from id: Int) -> [Movie]
    func isPageLoaded(page: Int) -> Bool
    func setFavoriteMovie(id: Int) -> Movie?
    func getMoviesYear() -> Set<String>
}

final class MovieMemoryRepository: MovieMemoryRepositoryProtocol {
    
    private var moviesDB = [Int :[Movie]]()
    
    func cache(page: Int, movies: [Movie]) {
        self.moviesDB[page] = movies
    }
    
    func getAllMovies() -> [Movie] {
        var moviesAux = [Movie]()
        
        let sortedMoviesByPage = moviesDB.sorted { (item1, item2) -> Bool in
            return item1.key < item2.key
        }
        
        for moviePage in sortedMoviesByPage {
            moviesAux.append(contentsOf: moviePage.value)
        }
        return moviesAux
    }
    
    func getAllFavoriteMovies() -> [Movie] {
        var moviesAux = [Movie]()
        
        let sortedMovies = moviesDB.sorted { (item1, item2) -> Bool in
            return item1.key < item2.key
        }
        
        for movie in sortedMovies {
            moviesAux.append(contentsOf: movie.value.filter({ (movie) -> Bool in
                return movie.liked
            }))
        }
        return moviesAux
    }
    
    func getMovies(from page: Int) -> [Movie] {
        if isPageLoaded(page: page) {
            return moviesDB[page]!
        } else {
            return []
        }
    }
    
    func getMovie(from id: Int) -> [Movie] {
        var results = [Movie]()
        for movieSet in moviesDB.values {
            results.append(contentsOf: movieSet.filter({
                movie in return movie.id == id
            }))
        }
        return results
    }
    
    func isPageLoaded(page: Int) -> Bool {
        return moviesDB.index(forKey: page) != nil
    }
    
    func setFavoriteMovie(id: Int) -> Movie?{
        for moviesPage in moviesDB.values {
            for movie in moviesPage {
                if movie.id == id {
                    movie.setFavorite(value: !movie.liked)
                    return movie
                }
            }
        }
        
        return nil
    }
    
    func getMoviesYear() -> Set<String> {
        var results = Set<String>()
        for movieSet in moviesDB.values {
            for movie in movieSet {
                results.insert(String(movie.releaseDate.prefix(4)))
            }
        }
        return results
    }
}


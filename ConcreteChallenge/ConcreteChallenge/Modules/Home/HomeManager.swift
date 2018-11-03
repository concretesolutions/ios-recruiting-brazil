//
//  HomeManager.swift
//  ConcreteChallenge
//
//  Created by Thiago  Wlasenko Nicolau on 30/10/18.
//  Copyright © 2018 Thiago  Wlasenko Nicolau. All rights reserved.
//

import Foundation
import RealmSwift

protocol HomeInterfaceProtocol {
    func set(state: HomeInterfaceState)
    func reload(_ indexPath: [IndexPath])
}

extension HomeInterfaceProtocol {
    func reload() {
        self.reload([])
    }
}

class HomeManager {
    var interface: HomeInterfaceProtocol?
    var movieProvider = MovieProvider()
    
    var movies = [MovieJSON]()
    var page = 0
    var totalPages = 0
    var totalResults = 0
    
    var isFetchInProgress = false
    
    
    
    init(_ interface: HomeInterfaceProtocol) {
        
        self.interface = interface
        self.movieProvider.delegate = self
        self.movieProvider.fetchGenres()
        
    }
    
    func fetchMovies() {
        
        guard !isFetchInProgress else {
            return
        }
        self.isFetchInProgress = true
        self.page += 1
        self.movieProvider.fetchPopularMovies(page: page) { newMovies, totalPages, totalResults in
            self.movies.append(contentsOf: newMovies)
            self.totalPages = totalPages
            self.totalResults = totalResults
            
            if self.page == 1 {
                self.interface?.reload()
            } else {
                self.interface?.reload(self.calculateIndexPathToReload(newMovies: newMovies))
            }
            
            self.isFetchInProgress = false
        }
    }
    
    func numberOfMovies() -> Int {
        return totalResults
    }
    
    func handleMovie(indexPath: IndexPath) {
        let movie = movieFor(index: indexPath.row)
        
        self.movieProvider.handle(movie: movie)
    }
    
    func movieFor(index: Int) -> Movie {
        let movieJson = self.movies[index]
        let movie = Movie()
        
        movie.id = movieJson.id
        movie.imageUrl = (movieJson.backdrop_path ?? movieJson.poster_path ?? "")
        movie.year = Int(String(movieJson.release_date?.prefix(4) ?? "0")) ?? 0
        movie.title = movieJson.title ?? ""
        movie.overview = movieJson.overview ?? ""
        
        self.movieProvider.fetchGenres { genres in
            guard let ids = movieJson.genre_ids else {
                return
            }
            
            for id in ids {
                if let genre = (genres.filter{ $0.id == id }).first {
                    
                    movie.genres.append(genre)
                }
            }
        }
        
        movie.isSaved = self.movieProvider.contain(id: movie.id)
        
        return movie
    }
    
    private func calculateIndexPathToReload(newMovies: [MovieJSON]) -> [IndexPath] {
        let startIndex = self.movies.count - newMovies.count
        let endIndex = startIndex + newMovies.count
        return (startIndex..<endIndex).map({ IndexPath(row: $0, section: 0) })
    }
}

extension HomeManager: MovieProviderDelegate {
    func handler(badRequest: BadRequest) {
        
        
        
    }
}

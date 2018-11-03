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
    func reload()
}

class HomeManager {
    var interface: HomeInterfaceProtocol?
    var movieProvider = MovieProvider()
    
    var movies = [Movie]()
    var page = 0
    var totalPages = 0
    var totalResults = 0
    
    var isFetchInProgress = false
    var filterText = ""
    
    
    init(_ interface: HomeInterfaceProtocol) {
        
        self.interface = interface
        self.movieProvider.delegate = self
        self.movieProvider.fetchGenres()
        self.fetchMovies()
    }
    
    func fetchMovies() {
        
        guard !isFetchInProgress else {
            return
        }
        self.isFetchInProgress = true
        self.page += 1
        self.movieProvider.fetchPopularMovies(page: page) { newMovies, totalPages, totalResults in
            
            let movies: [Movie] = newMovies.filter{ return self.filter(movie: $0)}
            
            self.movies.append(contentsOf: movies)
            
            if (!self.filterText.isEmpty && self.movies.count < 10) || newMovies.count == 0{
                self.totalResults = self.movies.count
                self.isFetchInProgress = false
                if self.page < totalPages - 10 {
                    print(self.page)
                    for _ in 0...9{
                        DispatchQueue.global(qos: .background).async {
                            self.fetchMovies()
                        }
                    }
                }
            } else {
                self.totalResults = totalResults
            }
            
            self.totalPages = totalPages
            
            
            self.interface?.reload()
            
        }
    }
    
    func numberOfMovies() -> Int {
        if self.totalResults == 0 {
            self.interface?.set(state: .error)
        } else {
            self.interface?.set(state: .normal)
        }
        
        return totalResults
    }
    
    func handleMovie(indexPath: IndexPath) {
        let movie = movieFor(index: indexPath.row)
        self.movieProvider.handle(movie: movie)
    }
    
    func movieFor(index: Int) -> Movie {
        return self.movies[index % self.movies.count]
    }
    
    func filter(movie: Movie) -> Bool {
        if !self.filterText.isEmpty {
            return movie.title.lowercased().range(of: self.filterText.lowercased()) != nil
        }
        
        return !self.movies.contains(movie)
    }
    
    func applyFilter(text: String){
        self.filterText = text
        self.page = 0
        self.totalResults = 0
        self.isFetchInProgress = false
        self.movies.removeAll()
        self.interface?.reload()
        self.fetchMovies()
    }
    
    private func calculateIndexPathToReload(amount: Int) -> [IndexPath] {
        let startIndex = totalResults
        let endIndex = startIndex + amount
        return (startIndex..<endIndex).map({ IndexPath(row: $0, section: 0) })
    }
    
    
}

extension HomeManager: MovieProviderDelegate {
    func handler(badRequest: BadRequest) {
        
        
        
    }
}

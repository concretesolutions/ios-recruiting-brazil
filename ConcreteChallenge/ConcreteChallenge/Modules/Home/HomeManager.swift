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
    func reload()
}

class HomeManager {
    var interface: HomeInterfaceProtocol?
    var provider = HomeProvider()
    
    var movies = [MovieJSON]()
    var page = 1
    
    let realm: Realm!
    
    init(_ interface: HomeInterfaceProtocol) {
        self.realm = try! Realm()
        self.interface = interface
        self.provider.delegate = self
    }
    
    func fetchMovies() {
        self.provider.fetchPopularMovies(page: page) { movies in
            
            self.movies = movies
            self.interface?.reload()
        }
    }
    
    func numberOfMovies() -> Int {
        return self.movies.count
    }
    
    func movieModelIn(index: Int) -> MovieCellModel? {
        let movie = self.movies[index]
        
        return MovieCellModel(title: movie.title ?? "", backdrop_path: movie.backdrop_path ?? "", poster_path: movie.poster_path ?? "")
    }
    
    func handleMovie(indexPath: IndexPath) {
        try! self.realm.write {
            let movie = movieFor(index: indexPath.row)
            
            if let movie = self.realm.object(ofType: Movie.self, forPrimaryKey: movie.id) {
                
                self.realm.delete(movie)
            } else {
                
               self.realm.add(movie)
            }
            
        }
    }
    
    private func movieFor(index: Int) -> Movie {
        let movieJson = self.movies[index]
        let movie = Movie()
        
        movie.id = movieJson.id
        movie.imageUrl = Network.manager.imageDomain + (movieJson.backdrop_path ?? movieJson.poster_path ?? "")
        movie.release_date = movieJson.release_date ?? ""
        movie.title = movieJson.title
        movie.overview = movieJson.overview ?? ""
        
        return movie
    }
}

extension HomeManager: HomeProviderDelegate {
    func handler(badRequest: BadRequest) {
        
        
        
    }
}

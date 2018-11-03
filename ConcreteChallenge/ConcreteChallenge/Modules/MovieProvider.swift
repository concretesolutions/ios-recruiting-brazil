//
//  HomeProvider.swift
//  ConcreteChallenge
//
//  Created by Thiago  Wlasenko Nicolau on 30/10/18.
//  Copyright © 2018 Thiago  Wlasenko Nicolau. All rights reserved.
//

import Foundation
import RealmSwift

protocol MovieProviderDelegate {
    func handler(badRequest: BadRequest)
}

class MovieProvider {
    var delegate: MovieProviderDelegate?
    let realm: Realm!
    
    init() {
        self.realm = try! Realm()
    }
    
    func fetchPopularMovies(page: Int, completion: @escaping ([MovieJSON], Int, Int) -> Void) {
        let parameters = [
            "api_key": Network.manager.apiKey,
            "page": page
        ] as [String: Any]
        
        Network.manager.request(Router.popularMovies, parameters: parameters, decodable: PopularMovies.self) { (popularMovies, badRequest) in
            if let badRequest = badRequest {
                self.delegate?.handler(badRequest: badRequest)
                return
            }
            
            guard let popularMovies = popularMovies, let results = popularMovies.results, let totalPages = popularMovies.total_pages, let totalResults = popularMovies.total_results else {
                print("No results")
                return
            }
            
            completion(results, totalPages, totalResults)
        }
    }
    
    func fetchGenres(_ completion: @escaping ([Genre]) -> Void = {_ in }) {
        
        if let allGenres = self.realm.objects(AllGenres.self).first {
            completion(Array(allGenres.genresList))
        } else {
            let parameters = [ "api_key": Network.manager.apiKey ]
            
            Network.manager.request(Router.genres, parameters: parameters, decodable: GenreJSON.self) { genreJSON, badRequest in
                if let badRequest = badRequest {
                    self.delegate?.handler(badRequest: badRequest)
                    return
                }
                
                guard let genreJSON = genreJSON, let genres = genreJSON.genres else {
                    return
                }
                
                if genres.count > 0 {
                    try! self.realm.write {
                        let allGenres = AllGenres()
                        
                        for genre in genres {
                            allGenres.genresList.append(genre)
                        }
                        self.realm.add(allGenres)
                        
                        completion(genres)
                    }
                }
                
            }
        }
    }
    
    func handle(movie: Movie) {
       
        try! self.realm.write {
            movie.isSaved = !movie.isSaved
            if let movie = self.realm.object(ofType: Movie.self, forPrimaryKey: movie.id) {
                self.realm.delete(movie)
            } else {
                self.realm.add(movie)
            }
        }
    }
    
    func load() -> [Movie] {
        let movies = self.realm.objects(Movie.self)
        return Array(movies)
    }
    
    func contain(id: Int) -> Bool {
        return self.realm.object(ofType: Movie.self, forPrimaryKey: id) != nil
    }
    
    func filteredLoad(text: String = "", filter: Filter) -> [Movie] {
        var movies = self.realm.objects(Movie.self)
        
        if !text.isEmpty {
            movies = movies.filter("title CONTAINS[c] '\(text)'")
        }
        
        if !filter.years.isEmpty {
            movies = movies.filter("year IN %@", filter.years)
        }
        
        
        
        if !filter.genres.isEmpty {
            var moviesArray : [Movie] = []
            
            for genre in filter.genres {
                moviesArray.append(contentsOf: Array(movies).filter({
                    return $0.genres.contains(genre)
                }))
            }
            
             return moviesArray
        }
        
       return Array(movies)
    }
    
    
}

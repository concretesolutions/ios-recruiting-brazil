//
//  TmdbAPI.swift
//  Movs Challenge Project
//
//  Created by Jezreel Barbosa on 15/01/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit
import CoreData

class TmdbAPI {
    // Static Properties
    
    static let didDownloadPageNN = Notification.Name("com.concrete.Movs-Challenge-Project.TmdbAPI.didDownloadPageNN")
    static let didDownloadGenresNN = Notification.Name("com.concrete.Movs-Challenge-Project.TmdbAPI.didDownloadGenresNN")
    
    static let genericErrorNN = Notification.Name("com.concrete.Movs-Challenge-Project.TmdbAPI.genericErrorNN")
    
    static let apiKey: String = "72ee2814ce7d37165e7a836cc8cf9186"
    
    static private(set) var movies: Set<Movie> = []
    static private(set) var popularMovies: [Movie] = []
    
    static private var popularPage: Int = 1
    static private var popularIndex: Int = 1
    
    static private var searchPage: Int = 1
    static private var searchIndex: Int = 1
    static private(set) var searchTask: URLSessionDataTask = URLSessionDataTask()
    
    // Static Methods
    
    static func decodeJSONFile<T>(from jsonResource: Data, to type: [T].Type) -> [T]? where T: Decodable {
        if let decoded = try? JSONDecoder().decode(type, from: jsonResource) {
            return decoded
        }
        else {
            print("Decode from json error")
            return nil
        }
    }
    static func decodeJSONFile<T>(from jsonResource: Data, to type: T.Type) -> T? where T: Decodable {
        if let decoded = try? JSONDecoder().decode(type, from: jsonResource) {
            return decoded
        }
        else {
            print("Decode from json error")
            return nil
        }
    }
    
    static func fetchPopularMoviesSet() {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        let session = URLSession.init(configuration: config)
        
        guard
            let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(TmdbAPI.apiKey)&language=en-US&page=\(TmdbAPI.popularPage)")
            else { return }
        let task = session.dataTask(with: url) { (data, response, error) in
            guard
                let resource = data, error == nil,
                let page = TmdbAPI.decodeJSONFile(from: resource, to: PopularMoviePage.self)
            else {
                if response == nil {
                    DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 1) {
                        TmdbAPI.fetchPopularMoviesSet()
                    }
                }
                else {
                    NotificationCenter.default.post(name: TmdbAPI.genericErrorNN, object: nil)
                }
                return
            }
            
            for movie in page.movies {
                let (_, member) = TmdbAPI.movies.insert(movie)
                
                member.popularIndex = TmdbAPI.popularIndex
                TmdbAPI.popularIndex += 1
            }
            
            TmdbAPI.popularPage += 1
            TmdbAPI.updatePopularMoviesArray()
            
            NotificationCenter.default.post(name: TmdbAPI.didDownloadPageNN, object: nil)
        }
        
        URLCache.shared.removeCachedResponse(for: task)
        task.resume()
    }
    
    static func fetchMovies(query: String, newSearch: Bool) {
        if newSearch {
            TmdbAPI.searchTask.cancel()
            TmdbAPI.searchPage = 1
            TmdbAPI.searchIndex = 1
            TmdbAPI.movies.forEach({$0.searchIndex = nil})
        }
        
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        let session = URLSession.init(configuration: config)
        
        guard
            let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(TmdbAPI.apiKey)&language=en-US&query=\(query)&page=\(TmdbAPI.searchPage)")
        else { return }
        TmdbAPI.searchTask = session.dataTask(with: url) { (data, response, error) in
            guard
                let resource = data, error == nil,
                let page = TmdbAPI.decodeJSONFile(from: resource, to: PopularMoviePage.self)
            else {
                if response == nil {
                    DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 1) {
                        TmdbAPI.fetchMovies(query: query, newSearch: false)
                    }
                }
                else {
                    NotificationCenter.default.post(name: TmdbAPI.genericErrorNN, object: nil)
                }
                return
            }
            
            for movie in page.movies {
                let (_, member) = TmdbAPI.movies.insert(movie)
                
                member.searchIndex = TmdbAPI.searchIndex
                TmdbAPI.searchIndex += 1
            }
            
            if !newSearch {
                TmdbAPI.searchPage += 1
            }
            
            NotificationCenter.default.post(name: TmdbAPI.didDownloadPageNN, object: nil)
        }
        
        URLCache.shared.removeCachedResponse(for: TmdbAPI.searchTask)
        TmdbAPI.searchTask.resume()
    }
    
    static func fetchGenres() {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        let session = URLSession.init(configuration: config)
        
        guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=72ee2814ce7d37165e7a836cc8cf9186&language=en-US") else { return }
        let task = session.dataTask(with: url) { (data, response, error) in
            guard
                let resource = data, error == nil,
                let _ = TmdbAPI.decodeJSONFile(from: resource, to: Genres.self)
            else {
                if response == nil {
                    DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 1) {
                        TmdbAPI.fetchGenres()
                    }
                }
                else {
                    NotificationCenter.default.post(name: TmdbAPI.genericErrorNN, object: nil)
                }
                return
            }
            
            NotificationCenter.default.post(name: TmdbAPI.didDownloadGenresNN, object: nil)
        }
        
        URLCache.shared.removeCachedResponse(for: task)
        task.resume()
    }
    
    static func fetchFavoriteMovies() {
        DispatchQueue.main.async {
            guard
                let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
            else { return }
            
            let request = NSFetchRequest<NSManagedObject>(entityName: "MovieEntity")
            
            do {
                let profiles = try context.fetch(request)
                print(profiles.count)
                for profile in profiles {
                    let movie = try Movie(profile: profile)
                    let (_, member) = TmdbAPI.movies.insert(movie)
                    member.isFavorite = movie.isFavorite
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    static private func updatePopularMoviesArray() {
        TmdbAPI.popularMovies = TmdbAPI.movies.filter({$0.popularIndex != nil}).sorted(by: {$0.popularIndex! < $1.popularIndex!})
    }
    
    // Public Types
    // Public Properties
    // Public Methods
    // Initialisation/Lifecycle Methods
    
    private init() {
        
    }
    
    // Override Methods
    // Private Types
    // Private Properties
    // Private Methods
}

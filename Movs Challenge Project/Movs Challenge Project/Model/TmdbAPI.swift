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
    
    static private(set) var movies: Set<Movie> = []
    
    static private var page: Int = 1
    
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
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=72ee2814ce7d37165e7a836cc8cf9186&language=en-US&page=\(TmdbAPI.page)") else { return }
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
            
            for (index, movie) in page.movies.enumerated() {
                let (_, member) = TmdbAPI.movies.insert(movie)
                
                member.page = TmdbAPI.page
                member.index = index
            }
            
            TmdbAPI.page += 1
            
            NotificationCenter.default.post(name: TmdbAPI.didDownloadPageNN, object: nil)
        }
        
        URLCache.shared.removeCachedResponse(for: task)
        task.resume()
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
            else { return }
            
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
    
    @objc static private func didChangeFavoriteMovie() {
        
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

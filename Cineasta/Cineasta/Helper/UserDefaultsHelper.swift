//
//  UserDefaultsHelper.swift
//  Cineasta
//
//  Created by Tomaz Correa on 04/06/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import Foundation

class UserDefaulstHelper {

    public static let shared = UserDefaulstHelper()
    
    private let userDefaults = UserDefaults.standard
    
    private init() {
    }
    
    public func saveObject<T: Codable>(object: T, forKey: String) {
        guard let data = try? JSONEncoder().encode(object) else { return }
        self.userDefaults.set(data, forKey: forKey)
    }
    
    public func getObject<T: Codable>(forKey: String) -> T? {
        guard let result = self.userDefaults.object(forKey: forKey) as? Data,
            let object = try? JSONDecoder().decode(T.self, from: result) else { return nil }
        return object
    }
    
    public func saveOrUpdateFavoriteList(movie: MovieViewData, forKey: String) {
        guard let result: [MovieViewData] = self.getObject(forKey: forKey) else {
            self.saveObject(object: [movie], forKey: forKey)
            return
        }
        var movies = result
        movies.append(movie)
        self.saveObject(object: movies, forKey: forKey)
    }

    public func removeFavorite(movie: MovieViewData, forKey: String) {
        guard let result: [MovieViewData] = self.getObject(forKey: forKey) else { return }
        var movies = result
        movies.removeAll(where: {$0.movieId == movie.movieId})
        self.saveObject(object: movies, forKey: forKey)
    }
}

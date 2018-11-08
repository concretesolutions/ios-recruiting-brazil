//
//  AppSettings.swift
//  Wonder
//
//  Created by Marcelo on 06/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation

private let shared = AppSettings()


class AppSettings {

    // genres list
    public var genresList = GenresList()
    
    // internet connection status
    public var isConnectedToInternet = false
    
    class var standard: AppSettings {
        return shared
    }
    
    // MARK: - Reachability Helper
    public func updateInternetConnectionStatus(_ status: Bool) {
        self.isConnectedToInternet = status
    }
    
    public func internetConnectionStatus() -> Bool {
        return self.isConnectedToInternet
    }

    // MARK: - Genres List
    public func loadGenresList() {
        let webService = WebService()
        webService.getGenresList { (genresResult) in
            // completion
            print("genresResult: \(genresResult)")
            self.genresList = genresResult
            let genres : [Genres] = self.genresList.genres
            // remove previous stored data
            self.removeCategories()
            
            // persist categories
            for genre in genres {
                self.setCategory(id: genre.id, name: genre.name)
            }
            
        }
    }

    // MARK: - User Defaults
    func getCategory(id: Int) -> String {
        let userDefaults = UserDefaults.standard
        let key = "id" + String(id)
        return userDefaults.string(forKey: key)!
    }
    
    func setCategory(id: Int, name: String) {
        let userDefaults = UserDefaults.standard
        let key = "id" + String(id)
        userDefaults.set(name, forKey: key)
        userDefaults.synchronize()
    }
    
    func removeCategories() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
//        print("removing categories")
//        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
    }
    
}

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
            self.removeDefualtsCategories()
            
            // persist categories
            for genre in genres {
                self.setDefualtsCategory(id: genre.id, name: genre.name)
            }
            
        }
    }

    // MARK: - Movie's category persistance
    
    func getDefualtsGenresList() -> GenresList {
        
        let result : GenresList = GenresList()
        
        for item in UserDefaults.standard.dictionaryRepresentation().keys {
            let index = item.index(item.startIndex, offsetBy: 2)
            let subStr = String(item[..<index])
            if subStr == "id" {
                let userDefaults = UserDefaults.standard
                let value : String = userDefaults.object(forKey: item) as! String
                let key : Int = Int(item.replacingOccurrences(of: "id", with: ""))!
                
                let genre = Genres(id: key, name: value)
                result.genres.append(genre)
            }
        }
        
        return result
    }
    
    
    func getDefualtsCategory(id: Int) -> String {
        let userDefaults = UserDefaults.standard
        let key = "id" + String(id)
        return userDefaults.string(forKey: key)!
    }
    
    func setDefualtsCategory(id: Int, name: String) {
        let userDefaults = UserDefaults.standard
        let key = "id" + String(id)
        userDefaults.set(name, forKey: key)
        userDefaults.synchronize()
    }
    
    func removeDefualtsCategories() {
        for item in UserDefaults.standard.dictionaryRepresentation().keys {
            let index = item.index(item.startIndex, offsetBy: 2)
            let subStr = String(item[..<index])
            if subStr == "id" {
                let userDefaults = UserDefaults.standard
                userDefaults.removeObject(forKey: item)
                userDefaults.synchronize()
            }
        }
    }
    
    
}

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
    public var genresList = GenresList(dictionary: NSDictionary())
    
    // internet connection status
    public var isConnectedToInternet = false
    
    class var standard: AppSettings {
        return shared
    }
    
    // MARK: - Reachability Helper
    public func updateInternetConnectionStatus(_ status: Bool) {
        self.isConnectedToInternet = status
        if status {
            print("🌎 internet ok 👍")
            
        }else{
            print("🌎 internet NOT ok ‼️")
        }
    }
    
    public func internetConnectionStatus() -> Bool {
        return self.isConnectedToInternet
    }

    // MARK: - Genres List
    public func loadGenresList() {
        let webService = WebService()
        webService.getGenresList { (genresResult) in
            // completion
            
            if genresResult.genres == nil {
                print("... error 1 ...")
                self.loadGenresList()
                
            }else if genresResult.genres?.count == 0 {
                print("... error 2 ...")
                self.loadGenresList()
            }else {
                print("*** OK GENRES LIST has been loaded! ****")
                self.genresList = genresResult
            }
            
            

        }
    }
    
    
}

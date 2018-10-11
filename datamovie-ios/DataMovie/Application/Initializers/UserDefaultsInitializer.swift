//
//  UserDefaultsInitializer.swift
//  DataMovie
//
//  Created by Andre Souza on 09/10/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

class UserDefaultsInitializer: Initializable {
    
    func performInitialization() {
        listMovieFilterDefaults()
    }
    
}

extension UserDefaultsInitializer {
    
    private func listMovieFilterDefaults() {
        if !UserDefaults.setupConfiguration.bool(forKey: .isInitialConfigurationDone) {
            UserDefaults.movieListFilters.set(false, forKey: .favorites)
            UserDefaults.movieListFilters.set(true, forKey: .watched)
            UserDefaults.movieListFilters.set(true, forKey: .notWatched)
            UserDefaults.setupConfiguration.set(true, forKey: .isInitialConfigurationDone)
        }
    }

}

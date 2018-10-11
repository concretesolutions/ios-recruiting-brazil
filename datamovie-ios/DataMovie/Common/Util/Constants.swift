//
//  Constants.swift
//  DataMovie
//
//  Created by Andre Souza on 09/10/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

enum Constants {
    
}

struct SetupConfiguration: BoolUserDefaultable {
    enum BoolDefaultKey: String {
        case isInitialConfigurationDone
    }
}

struct MovieListFilters: BoolUserDefaultable {
    enum BoolDefaultKey: String {
        case favorites
        case notWatched
        case watched
    }
}


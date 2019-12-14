//
//  Dependencies.swift
//  Movs
//
//  Created by Gabriel D'Luca on 09/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

protocol HasAPIManager {
    var apiManager: MoviesAPIManager { get }
}

protocol HasStorageManager {
    var storageManager: StorageManager { get }
}

class Dependencies: HasAPIManager, HasStorageManager {
    
    // MARK: - Properties
    
    let apiManager: MoviesAPIManager
    let storageManager: StorageManager

    // MARK: - Initializers and Deinitializers
    
    init(apiManager: MoviesAPIManager = MoviesAPIManager(), storageManager: StorageManager = StorageManager()) {
        self.apiManager = apiManager
        self.storageManager = storageManager
    }
}

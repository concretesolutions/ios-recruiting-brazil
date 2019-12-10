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

protocol HasCoreDataManager {
    var coreDataManager: CoreDataManager { get }
}

class Dependencies: HasAPIManager, HasCoreDataManager {
    
    // MARK: - Properties
    
    let apiManager: MoviesAPIManager
    let coreDataManager: CoreDataManager

    // MARK: - Initializers and Deinitializers
    
    init(apiManager: MoviesAPIManager = MoviesAPIManager(), coreDataManager: CoreDataManager = CoreDataManager()) {
        self.apiManager = apiManager
        self.coreDataManager = coreDataManager
    }
}

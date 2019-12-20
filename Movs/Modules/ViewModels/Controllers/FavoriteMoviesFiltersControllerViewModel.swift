//
//  FavoriteMoviesFiltersControllerViewModel.swift
//  Movs
//
//  Created by Gabriel D'Luca on 20/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation

class FavoriteMoviesFiltersControllerViewModel {

    // MARK: - Dependencies
    
    typealias Dependencies = HasStorageManager
    private let storageManager: StorageManager
    
    // MARK: - Properties
    
    weak var coordinator: FavoriteMoviesFiltersCoordinator?
    
    // MARK: - Initializers and Deinitializers
    
    init(dependencies: Dependencies) {
        self.storageManager = dependencies.storageManager
    }
}

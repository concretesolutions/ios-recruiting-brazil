//
//  MoviesCollectionViewModel.swift
//  Movs
//
//  Created by Gabriel D'Luca on 03/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation
import Combine

class MoviesControllerViewModel {
    
    internal let apiManager = MoviesAPIManager()
    internal let decoder = JSONDecoder()
    internal var isFetchingData: Bool = false
    
    // MARK: - Publishers
    
    @Published var currentPage: Int
    @Published var numberOfMovies: Int
        
    // MARK: - Initializers and Deinitializers
    
    init(currentPage: Int = 0, numberOfMovies: Int = 0) {
        self.currentPage = currentPage
        self.numberOfMovies = numberOfMovies
    }
    
    func requestMorePopularMovies() {
        self.isFetchingData = true
        
        self.apiManager.getPopularMovies(page: self.currentPage + 1, completion: { (data, error) in
            if let data = data {
                do {
                    let popularMovies = try self.decoder.decode(PopularMoviesDTO.self, from: data)
                    self.currentPage = popularMovies.page
                    self.numberOfMovies += popularMovies.movies.count
                } catch {
                    print(error)
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                self.isFetchingData = false
            })
        })
    }
}

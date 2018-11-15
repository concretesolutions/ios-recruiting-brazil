//
//  TMDataManager.swift
//  ConcreteTMDb
//
//  Created by Pedro Del Rio Ortiz on 15/11/18.
//  Copyright © 2018 Pedro Ortiz. All rights reserved.
//

import Foundation

class TMDataManager {
    
    // MARK: - DataSearch delegate, called when assyn data arrives
    weak var dataCompleted: MoviesDataFetchCompleted?
    
    func fetchMovies() {
        
        var movies: [Movie] = []
        let urlString = "https://api.punkapi.com/v2/beers?page=1&per_page=80"
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            
            DispatchQueue.main.async {
                
                if let err = err {
                    print("Failed to get data from url:", err)
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    movies = try decoder.decode([Movie].self, from: data)
                    
                    self.dataCompleted?.fetchComplete(for: movies)
                    
                } catch let jsonErr {
                    print("Error to decode json:", jsonErr)
                }
            }
            }.resume()
    }
}

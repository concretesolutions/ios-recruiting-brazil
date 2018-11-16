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
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=e2417760a16d55fdc805d2c23c69022b&language=en-US&page=1"
        
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
    
    func fetchMovieGenres() {
        let urlString = "https://api.themoviedb.org/3/genre/movie/list?api_key=e2417760a16d55fdc805d2c23c69022b&language=en-US"
        
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
                    
                } catch let jsonErr {
                    print("Error to decode json:", jsonErr)
                }
            }
        }.resume()
    }
}

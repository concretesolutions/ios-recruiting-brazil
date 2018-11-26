//
//  TMDataManager.swift
//  ConcreteTMDb
//
//  Created by Pedro Del Rio Ortiz on 15/11/18.
//  Copyright © 2018 Pedro Ortiz. All rights reserved.
//

import Foundation

class TMDataManager {
    
    static var movies: [Movie] = []
    static var genres: [Genre] = []
    
    // MARK: - DataSearch delegate, called when assyn data arrives
    static weak var moviesDataCompletedDelegate: MoviesDataFetchCompleted?
    static weak var genresDataCompletedDelegate: GenresDataFetchCompleted?
    static weak var exceptionDelegate: PresentMessageForException?
    
    static func fetchMovies(page: Int) {
        
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=e2417760a16d55fdc805d2c23c69022b&language=en-US&page=\(page)"
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            
            DispatchQueue.main.async {
                
                if let err = err {
                    print("Failed to get data from url:", err)
                    self.exceptionDelegate?.presentGenericErrorMessage()
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let res = try decoder.decode(MovieResponse.self, from: data)
                    self.movies.append(contentsOf: res.movies)
                    
                    if let delegate = self.moviesDataCompletedDelegate {
                        delegate.fetchComplete(for: movies)
                    }
                    
                } catch let jsonErr {
                    print("Error to decode json:", jsonErr)
                }
            }
        }.resume()
    }
    
    static func fetchMovieGenres() {
       
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
                    let res = try decoder.decode(GenreResponse.self, from: data)
                    self.genres = res.genres
                    
                    if let delegate = self.genresDataCompletedDelegate {
                        delegate.fetchComplete(for: self.genres)
                    }
                    
                } catch let jsonErr {
                    print("Error to decode json:", jsonErr)
                }
            }
        }.resume()
    }
}

//
//  MovieModel.swift
//  RecruitingChallenge
//
//  Created by Giovane Barreira on 11/30/19.
//  Copyright © 2019 Giovane Barreira. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

protocol MovieManagerDelegate {
    func didUpdateMovies(movies: [MoviesModel])
    func didFailWithError(error: Error)
}

class MovieManager {
    
    let moviesSearchURL = "https://api.themoviedb.org/3/search/movie?api_key=7cdacdf12c2178d78b845d5b3ce14475&language=en-US&page=1&include_adult=false"
    
    let moviesPopular = "https://api.themoviedb.org/3/movie/popular?api_key=7cdacdf12c2178d78b845d5b3ce14475&language=en-US&page=1"
    
    let moviePosterPath = "https://image.tmdb.org/t/p/w185_and_h278_bestv2/"
    var delegate: MovieManagerDelegate?
    var moviesArray: [MoviesModel] = []
    
    func fetchMovie(movieName: String) {
        //Fetch using query movie name
        let urlString = "\(moviesSearchURL)&query=\(movieName)"
        performRequest(urlString: urlString )
    }
    
    func showMostPopularMovies() {
        performRequest(urlString: moviesPopular)
    }
    
    func performRequest(urlString: String) {
        //Create a URL
        if let url = URL(string: urlString) {
            //URL session
            let session = URLSession(configuration: .default)
            //Giving the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if let err = error {
                    self.delegate?.didFailWithError(error: err)
                    return
                }
                //Convert Data type to String
                if let safeData = data {
                    if let movie = self.parseJson(moviesData: safeData) {
                        self.delegate?.didUpdateMovies(movies: movie)
                    }
                }
            }
            //Start the task
            task.resume()
        }
    }
    
    func parseJson(moviesData: Data) -> [MoviesModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MovieData.self, from: moviesData)
            
            for (_, movieDecoded) in decodedData.results.enumerated() {
                let movieTitle = movieDecoded.title
                var posterPath: String = ""
                
                if let path = movieDecoded.poster_path {
                    posterPath = moviePosterPath + path
                }
                
                let releaseDate = movieDecoded.release_date
                let genres = movieDecoded.genre_ids
                let overview = movieDecoded.overview
                
                
                let movie = MoviesModel(movieTitle: movieTitle, posterImage: posterPath, releaseDate: releaseDate, genreIds: genres, overview: overview)
                
                self.moviesArray.append(movie)
            }
            
            return moviesArray
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}


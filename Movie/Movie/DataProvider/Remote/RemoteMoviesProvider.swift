//
//  RemoteMoviesProvider.swift
//  Movie
//
//  Created by Elton Santana on 09/07/19.
//  Copyright © 2019 Memo. All rights reserved.
//

import Foundation
import Moya

class RemoteMoviesProvider {
    fileprivate let provider = MoyaProvider<TheMovieDBMoyaProvider>()
}

extension RemoteMoviesProvider: MoviesProvider {
  
    func getPopularMovies(page: Int, completion: @escaping CompletionResponse<[Movie]>) {
        self.provider.request(.popular(page: page)) { (result) in
            if let error = result.error {
                print("error registerUser:\(error.errorDescription!)")
                completion(nil, error)
                return
            }
            
            if let response = result.value {
                if response.statusCode == 200 {
                    do {
                        let page = try Page(data: response.data)
                        let movies = page.results
                        completion(movies, nil)
                    } catch(let error) {
                        completion(nil, error)
                    }
                }
            }
        }
    }
    
    func getAllGenres(completion: @escaping CompletionResponse<[Genre]>) {
        self.provider.request(.genres) { (result) in
            if let error = result.error {
                print("error registerUser:\(error.errorDescription!)")
                completion(nil, error)
                return
            }
            
            if let response = result.value {
                if response.statusCode == 200 {
                    do {
                        let genres = try Genres(data: response.data)
                        let genresList = genres.genres
                        completion(genresList, nil)
                    } catch(let error) {
                        completion(nil, error)
                    }
                }
            }
        }
    }
        
        
}

//
//  TMDBManager.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 19/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import Foundation

class TMDBManager{
    
    private var popularMoviesResponse: TMDBResponse?
    
    private var authParams: [URLQueryItem]{
        return [
            URLQueryItem(name: "api_key", value: TMDBConfig.privateKey),
            URLQueryItem(name: "language", value: TMDBConfig.langugae.portuguese)
        ]
    }
    
    func getPopularMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void){
        let endPoint = TMDBConfig.endPoint.popular
        var urlComponents = URLComponents(string: endPoint)
        
        var queryItems:[URLQueryItem] = [URLQueryItem(name: "page", value: String(page))]
        queryItems.append(contentsOf: authParams)
        
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else{
            completion(.error(TMDBError.buildingURL("error creating URL for endpoint:\(endPoint)")))
            return
        }
        
        _ = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else{
                completion(.error(TMDBError.gettingData("error getting data with error:\(error?.localizedDescription ?? "")")))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do{
                let moviesResponse = try jsonDecoder.decode(TMDBResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(moviesResponse.results))
                }
            } catch {
//                print(String.init(data: data, encoding: String.Encoding.utf8)!)
                completion(.error(TMDBError.jsonSerialization(error.localizedDescription)))
            }
            
            }.resume()
    }
    
    func getGenres(completion: @escaping (Result<[Genre]>) -> Void){
        let endPoint = TMDBConfig.endPoint.genres
        var urlComponents = URLComponents(string: endPoint)
        
        var queryItems:[URLQueryItem] = []
        queryItems.append(contentsOf: authParams)
        
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else{
            completion(.error(TMDBError.buildingURL("error creating URL for endpoint:\(endPoint)")))
            return
        }
        
        _ = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else{
                completion(.error(TMDBError.gettingData("error getting data with error:\(error?.localizedDescription ?? "")")))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do{
                let genresResponse = try jsonDecoder.decode(GenreResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(genresResponse.genres))
                }
            } catch {
                completion(.error(TMDBError.jsonSerialization(error.localizedDescription)))
            }
            
            }.resume()
    }
    
}

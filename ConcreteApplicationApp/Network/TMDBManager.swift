//
//  TMDBManager.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 19/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import Foundation

public enum TMDBError:Error{
    case buildingURL(String)
}

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
            //FIXME: create error
            print("could not create URL")
            completion(.error(TMDBError.buildingURL("xxx")))
            return
        }
        
        _ = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else{
                //FIXME: create error
                print("could not get data")
                completion(.error(TMDBError.buildingURL("xxx")))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do{
                let moviesResponse = try jsonDecoder.decode(TMDBResponse.self, from: data)
                self.popularMoviesResponse = moviesResponse
                let results = moviesResponse.results
                DispatchQueue.main.async {
                    completion(.success(results))
                }
            } catch {
                //FIXME:- change error
                completion(.error(TMDBError.buildingURL(error.localizedDescription)))
            }
            
            }.resume()
    }
    
}

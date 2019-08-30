//
//  MoviesService.swift
//  Concrete Movies
//
//  Created by Lucas Daniel on 24/08/19.
//  Copyright © 2019 Lucas. All rights reserved.
//

import Foundation
import Alamofire

class MoviesService {
    
    let headers: HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    func getMovies(completion: @escaping (MoviesBase?)->()) {
        
        Alamofire.request(URLs.baseURL, headers: headers)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                    
                case .success(_ ):
                    
                    let decoder = JSONDecoder()
                    let data = response.data
                    
                    do {
                        
                    if let dataFromJSON = data {
                        print(dataFromJSON)
                        let result = try decoder.decode(MoviesBase.self, from: dataFromJSON)
                            completion(result)
                        }
                        
                    } catch {
                        completion(nil)
                    }
                    
                case .failure(let error):
                    completion(nil)
                }
        }
    }
    
    func getMoviesDetail(movieID: Int, completion: @escaping (MoviesDetail?)->()) {
        print("https://api.themoviedb.org/3/movie/\(movieID)?api_key=60471ecf5f288a61c69c6592c9d9e1cf")
        Alamofire.request("https://api.themoviedb.org/3/movie/\(movieID)?api_key=60471ecf5f288a61c69c6592c9d9e1cf", headers: headers)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                    
                case .success(_ ):
                    
                    let decoder = JSONDecoder()
                    let data = response.data
                    
                    do {
                        
                        if let dataFromJSON = data {
                            print(dataFromJSON)
                            let result = try decoder.decode(MoviesDetail.self, from: dataFromJSON)
                            completion(result)
                        }
                        
                    } catch {
                        completion(nil)
                    }
                    
                case .failure(let error):
                    completion(nil)
                }
        }
    }
    
    
}

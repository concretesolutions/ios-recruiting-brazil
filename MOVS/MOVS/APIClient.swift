//
//  APIClient.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 20/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

protocol APIClient: API {
    var page: Int { get set }
    
    var base: String{ get }
    
    var path: String{ get }
    
    
    var session: URLSession { get }
    func fetch<T: Decodable>(completion: @escaping (Result<T, APIError>) -> Void)
}

extension APIClient{
    var base: String{
        return "https://api.themoviedb.org"
    }
    
    var path: String{
        return "/3/movie/popular"
    }
    
    func fetch<T: Decodable>(completion: @escaping (Result<T, APIError>) -> Void) {
        session.dataTask(with: requestMovies) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(Result.failure(.requestFailed))
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let model = try JSONDecoder().decode(T.self, from: data)
                        completion(Result.success(model))
                    } catch {
                        completion(Result.failure(.decodeFailure))
                    }
                }else{
                    completion(Result.failure(.invalidData))
                }
            }else{
                completion(Result.failure(.requestFailed))
            }
        }.resume()
    }
}

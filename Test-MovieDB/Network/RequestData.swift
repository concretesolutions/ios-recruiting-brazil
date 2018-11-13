//
//  RequestData.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 12/11/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import Foundation

class RequestData {
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20.0
        return config
    }()
    private static let session = URLSession(configuration: configuration)
    
    class func getPopularData<T: Codable>(page: Int, completion: @escaping (T) -> Void, onError: @escaping (LoadError) -> Void) {
        
        let path = "https://api.themoviedb.org/3/movie/popular?page=\(page)&language=en-US&api_key=ba8157788e70a54b6eb17392403e33c6"
        
        guard let url = URL(string: path) else {
            return onError(.url)
        }
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            self.requestResponse(completion: completion, onError: onError)(data, response, error)
        }
        dataTask.resume()
    }
    
    class func getSearchData<T: Codable>(searchString: String, page: Int, completion: @escaping (T) -> Void, onError: @escaping (LoadError) -> Void) {
        
        let path = "https://api.themoviedb.org/3/search/company?api_key=ba8157788e70a54b6eb17392403e33c6&query=\(searchString)&page=\(page)"
        
        guard let url = URL(string: path) else {
            return onError(.url)
        }
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            self.requestResponse(completion: completion, onError: onError)(data, response, error)
        }
        dataTask.resume()
    }
    
    class func requestResponse<T: Codable>(completion: @escaping (T) -> Void, onError: @escaping (LoadError) -> Void) -> ((Data?, URLResponse?, Error?) -> Void) {
        
        return { data, response, error in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    onError(.noResponse)
                    return
                }
                if response.statusCode == 200 {
                    guard let data = data else { return }
                    do {
                        let returnData = try JSONDecoder().decode(T.self, from: data)
                        completion(returnData)
                    } catch {
                        onError(.invalidJSON)
                    }
                    
                } else {
                    onError(.responseStatusCode(code: response.statusCode))
                }
            } else {
                onError(.taskError(error: error!))
            }
        }
    }
}


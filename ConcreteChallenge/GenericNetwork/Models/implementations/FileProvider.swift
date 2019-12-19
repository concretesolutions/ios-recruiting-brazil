//
//  FileProvider.swift
//  GenericNetwork
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

/// A provider implementation responsible for providing files. For example, this can be used for requesting images.
public class FileProvider<RouteType: Route>: Provider {
    public init() {
        
    }
    /// Makes a request for the given Route
    /// - Parameters:
    ///   - route: the route containing the wanted data
    ///   - completion: a completion called when the request is completed. Returns the URL of the file or a error.
    public func request(route: RouteType, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let routeURL = route.completeUrl else {
            completion(.failure(NetworkError.wrongURL(route)))
            return
        }
        
        let routeRequestURL = URLRequest(url: routeURL, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60)
        
        let downloadTask = URLSession.shared.downloadTask(with: routeRequestURL) { (url, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let responseUrl = url else {
                completion(.failure(NetworkError.noResponseData))
                return
            }
            
            completion(.success(responseUrl))
        }
        
        downloadTask.resume()
    }
}

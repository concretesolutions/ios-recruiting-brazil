//
//  URLSessionDataProvider.swift
//  GenericNetwork
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

/// A default implementation of ParsableProvider made with URLSession and dataTask.
public class URLSessionDataProvider<RouteType: Route, ParserType: Parser>: ParserProvider {
    public var parser: ParserType
    
    
    /// Initilized the URLSessionProvider
    /// - Parameter parser: the parser that is going to be used for parsing the requested Data.
    public init(parser: ParserType) {
        self.parser = parser
    }
    
    public func request(route: RouteType, completion: @escaping (Result<Data, Error>) -> Void) {
        // the other route methods supossed to be implemmented when they be necessary in the future.
        guard route.method == .get else {
            fatalError("URLSessionProvider doesnt support \(route.method.rawValue) method")
        }
        
        guard let routeURL = route.completeUrl else {
            completion(.failure(NetworkError.wrongURL(route)))
            return
        }
        
        let routeRequestURL = URLRequest(url: routeURL, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60)
        
        let dataTask = URLSession.shared.dataTask(with: routeRequestURL) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.noHttpResponse))
                return
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                guard let responseData = data else {
                    completion(.failure(NetworkError.noResponseData))
                    return
                }
                completion(.success(responseData))
            default:
                //only responses between 200 and 299 are normal responses.
                completion(.failure(NetworkError.httpError(httpResponse.statusCode)))
            }
        }
        
        dataTask.resume()
    }
}

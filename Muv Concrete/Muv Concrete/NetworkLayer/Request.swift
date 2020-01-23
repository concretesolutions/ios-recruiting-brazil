//
//  Request.swift
//  Muv Concrete
//
//  Created by Mariaelena Silveira on 15/01/20.
//  Copyright © 2020 Mariaelena Silveira. All rights reserved.
//

import Foundation

protocol NetworkProtocol {
    func dispatch<T: Codable>(endPoint: ServiceRoute, type: T.Type, completionHandler: @escaping (T?, HTTPURLResponse?, Error?) -> Void)
}

public struct Request: NetworkProtocol {
    
    public static let instance = Request()
    private init() {}
    
    func dispatch<T: Codable>(endPoint: ServiceRoute, type: T.Type, completionHandler: @escaping (T?, HTTPURLResponse?, Error?) -> Void) {
        guard var urlRequest = endPoint.request else { return }
        
        if let headers = endPoint.headers {
            urlRequest.allHTTPHeaderFields = headers
        }
        
        if endPoint.body != nil {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: endPoint.body as Any, options: .prettyPrinted)
            } catch {
                fatalError("Error encoding body")
            }
        }
       
        URLSession.shared.dataTask(with: urlRequest){ (data, response, error) in
            
//            if let error = error as NSError?,
//                error.domain == NSURLErrorDomain,
//                error.code == NSURLErrorNotConnectedToInternet {
//                completionHandler(nil, nil, nil)
//            }
            
            guard let response = response as? HTTPURLResponse else {
                completionHandler(nil, nil, error)
                return
            }
            
            if response.statusCode >= 200, response.statusCode <= 299 {
                guard let novaData = data else { return }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .millisecondsSince1970
                    
                    let dadoDecodificado = try decoder.decode(type.self, from: novaData)
                    completionHandler(dadoDecodificado, response, nil)
                    
                } catch let error{
                    print(error)
                    completionHandler(nil, response, error)
                }
            } else {
                completionHandler(nil, response, error)
            }
        }.resume()
    }
}

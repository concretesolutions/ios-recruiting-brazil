//
//  Networking.swift
//  Movs
//
//  Created by Franclin Cabral on 1/18/19.
//  Copyright © 2019 franclin. All rights reserved.
//

import Foundation

protocol NetworkingProtocol {
    func get(_ url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
    func post(_ url: URL, body: Data, completion: @escaping (Data?, URLResponse?, Error?) ->
        ())
}

class Networking: NetworkingProtocol {
    
    private var session: URLSession = URLSession.shared
    
    init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10.0
        session = URLSession(configuration: config)
    }
    
    func get(_ url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        
        let body = Data(base64Encoded: "{}".data(using: String.Encoding.utf8)!)
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.httpBody = body
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            completion(data, response, error)
        }
        
        task.resume()
    }
    
    func post(_ url: URL, body: Data, completion: @escaping (Data?, URLResponse?, Error?) ->
        ()) {
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        let headers = ["content-type": "application/json"]
        
        request.allHTTPHeaderFields = headers
        request.httpMethod = "POST"
        request.httpBody = body
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            completion(data, response, error)
        }
        
        task.resume()
    }
}

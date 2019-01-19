//
//  Networking.swift
//  Movs
//
//  Created by Franclin Cabral on 1/18/19.
//  Copyright © 2019 franclin. All rights reserved.
//

import Foundation

protocol NetworkingProtocol {
    func get(_ url: URL, completion: @escaping (Data?, Error?) -> ())
}

class Networking: NetworkingProtocol {
    
    private var session: URLSession = URLSession.shared
    
    init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30.0
        session = URLSession(configuration: config)
    }
    
    func get(_ url: URL, completion: @escaping (Data?, Error?) -> ()) {
        let task = session.dataTask(with: url) { (data, response, error) in
            completion(data, error)
        }
        
        task.resume()
    }
}

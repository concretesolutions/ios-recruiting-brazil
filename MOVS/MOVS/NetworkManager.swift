//
//  NetworkManager.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 18/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class NetworkManager: APIClient{
    
    public static let shared: NetworkManager = NetworkManager()
    
    var page: Int = 1
    
    var session: URLSession
    
    private init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    private convenience init() {
        self.init(configuration: .default)
    }
    
    func fetchMovies(completion: @escaping (Result<Response, APIError>) -> Void){
        fetch { (result) in
            completion(result)
        }
    }
}

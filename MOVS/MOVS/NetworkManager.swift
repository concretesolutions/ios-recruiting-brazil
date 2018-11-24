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
    
    var path: String = RequestType.feed.rawValue
    
    var page: Int = 0
    
    var query: String?
    
    var session: URLSession
    
    private init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    private convenience init() {
        self.init(configuration: .default)
    }
    
    private func changeUILoader(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = !UIApplication.shared.isNetworkActivityIndicatorVisible
    }
    
    func fetchMovies(withRequest request: RequestType, andSearchText text: String? = nil, completion: @escaping (Result<Response, APIError>) -> Void){
        changeUILoader()
        path = request.rawValue
        if let searchText = text {
            query = searchText
        }
        
        fetch { (result) in
            completion(result)
        }
        changeUILoader()
    }
    
    func fetchGenres(completion: @escaping (Result<ResponseGenre, APIError>) -> Void){
        path = RequestType.genres.rawValue
        fetch { (result) in
            completion(result)
        }
    }
}

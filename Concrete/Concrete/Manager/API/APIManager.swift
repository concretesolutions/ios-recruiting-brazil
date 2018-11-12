//
//  APIManager.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 11/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//

import UIKit

class APIManager: NSObject {
    
    // MARK: - Properties
    // MARK: Private
    static let shared:APIManager = APIManager()
    
    private let session = URLSession(configuration: .default)
    
    // MARK: - Init
    private override init() {
        super.init()
    }
    
    // MARK: - Functions
    // MARK: Private
    private func setStatusBar(loading:Bool){
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = loading
        }
    }
    
    private func endpoint<T: APIRequest>(for request: T) -> URL {
        guard let parameters = try? URLQueryEncoder.encode(request) else { fatalError("Wrong parameters") }
        let hash = Constants.MarvelAPI.hash
        let url = URL(
            string: "\(Constants.MarvelAPI.baseEndpoint)\(request.endpoint)?ts=\(Constants.MarvelAPI.ts)&hash=\(hash)&apikey=\(Constants.MovieAPI.publicKey)&\(parameters)")!
        return url
    }
    
    //TODO: Prepare Endpoint functions
    //TODO: Prepare fetch request functions
}

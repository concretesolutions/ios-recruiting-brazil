//
//  NLLoadImage.swift
//  NetworkLayerModule
//
//  Created by Marcos Felipe Souza on 13/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation


public class NLLoadImage {
    
    
    private let urlSession =  URLSession.shared
    private var dataTask: URLSessionDataTask?
    public init() {}
    
    
    public func loadImage(absoluteUrl: String, completion: @escaping (_ data: Data?) -> Void) {
        
        guard let url = URL(string: absoluteUrl) else {
                completion(nil)
                return
        }
        
        let urlRequest = URLRequest(url: url)
        self.dataTask = urlSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            completion(data)
        })
        
        self.dataTask?.resume()
    }
    
    public func cancelLoadImage(){
        self.dataTask?.cancel()
    }
    
}

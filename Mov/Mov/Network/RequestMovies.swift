//
//  RequestMovies.swift
//  Mov
//
//  Created by Victor Leal on 20/07/19.
//  Copyright © 2019 Victor Leal. All rights reserved.
//

import Foundation
import UIKit

class RequestMovies{
    
    var results: [Result]? = nil
    static let shared: RequestMovies = RequestMovies()
    
    
    func request(){
        
        let getURL = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=3849e10119b257c6dc0cea7917d409d0")!
        
        var getRequest = URLRequest(url: getURL)
        getRequest.httpMethod = "GET"
        
        let request = URLSession.shared.dataTask(with: getRequest) { (data, responde, error) in
            
            
            
            if let error = error{
                print(error.localizedDescription)
            }
            
            if let data = data{
                
                
                
                do{
                    
                    
                    let movies = try JSONDecoder().decode(Empty.self, from: data)
                    
                    
                    if let a = movies.results?.count{
                        print(a)
                    }
                    
                    
                    
                    
                    
                    self.results = movies.results
                    
                    
                } catch let jsonError{
                    print(jsonError.localizedDescription)
                }
                
                
                
            }
            
            
            
            
            
        }
        
        request.resume()
    }
}


//
//  API.swift
//  MovieFetcher
//
//  Created by Pedro Azevedo on 23/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import Foundation
import UIKit

let api = API()

final class API{
    
    
    func movieSearch(urlStr:String,onCompletion:@escaping(MovieSearch)->()){
        
        let urlString = urlStr
        
        guard let url = URL(string: urlString) else {fatalError("Could not retrieve random url")}
        
        let task = URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            guard let data = data else{
                
                fatalError("Could not retrieve data")
            }
            
            guard let movie = try? JSONDecoder().decode(MovieSearch.self, from: data) else {
                fatalError("Failed to decode movie")
            
            }
            onCompletion(movie)
            
        }
        
        task.resume()
        
    }
    
    
   
    
    func retrieveImage(urlStr:String,onCompletion:@escaping(UIImage)->()){
        
        let urlString = urlStr
             
             guard let url = URL(string: urlString) else {fatalError("Could not retrieve random url")}
             
             let task = URLSession.shared.dataTask(with: url) { (data, resp, err) in
                 
                 guard let data = data else{
                     
                     fatalError("Could not retrieve data")
                 }
                 
                guard let image:UIImage = UIImage(data: data) else {
                     fatalError("Failed to decode movie")
                 
                 }
                 onCompletion(image)
                 
             }
             
             task.resume()
             
         }
    
        
        
        
    

    
    
}

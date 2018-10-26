//
//  JsonLoader.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 26/10/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import UIKit

//Delegate protocol
protocol JsonLoaderDelegate{
    func loaderCompleted(result:SearchResult)
}

class JsonLoader: NSObject {
    
    var delegate :JsonLoaderDelegate?
    let apiKey = "547271c9" //This api key have limited data requests per day, use yout own key if it is not working
    
    func searchRequest(withText text:String, type:String){
        
        var urlString = "https://www.omdbapi.com/?apikey=\(apiKey)&s=\(text)&type=\(type)"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        guard let url = URL(string: urlString) else{
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        let session:URLSession = URLSession(configuration: URLSessionConfiguration.default)
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            do{
                
                let result = try JSONDecoder().decode(SearchResult.self, from: data!)
                self.delegate?.loaderCompleted(result: result)
                
            } catch {
                
                print("Unable to load from webservice... Please verify if the server os online")
                
            }
            
        }
        
        dataTask.resume()
        
    }
    
}

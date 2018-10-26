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
    func loaderFailed()
}

class JsonLoader: NSObject {
    
    var delegate :JsonLoaderDelegate?
    fileprivate let apiKey = "1bc55c5473e9c54bba20ab9213165879" //This api key have limited data requests of 40 requests every 10 seconds
    
    func searchRequest(withText text:String, type:DestinationScreen){
        
        var urlString = "https://api.themoviedb.org/3/search/\(type.rawValue)?api_key=\(apiKey)&language=en-US&query=\(text)&include_adult=false&page=1"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        print(urlString)
        
        guard let url = URL(string: urlString) else{
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        let session:URLSession = URLSession(configuration: URLSessionConfiguration.default)
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            do{
                
                if(type == .tvShows){
                    //Decode as TV Shows
                    let result = try JSONDecoder().decode(SearchResult.self, from: data!)
                    self.delegate?.loaderCompleted(result: result)
                    
                }else{
                    //Decode as Movies
                    let result = try JSONDecoder().decode(SearchResult.self, from: data!)
                    self.delegate?.loaderCompleted(result: result)
                }
                
            } catch {
                
                print("Unable to load from webservice... Please verify if the server os online of if you have reached the limit of data requests (40 requests every 10 seconds)")
                
                self.delegate?.loaderFailed()
                
            }
            
            
        }
        
        dataTask.resume()
        
    }
    
}

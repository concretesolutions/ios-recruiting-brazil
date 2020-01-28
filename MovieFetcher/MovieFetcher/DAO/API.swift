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
    
    
    func movieSearch(urlStr:String,view:UIViewController,onCompletion:@escaping(MovieSearch)->()){
        
        let urlString = urlStr
        
        guard let url = URL(string: urlString) else {
            
            DispatchQueue.main.async {
                dao.displayError(title: "Sorry", message: "We could't retrieve the movies at the time", view: view)
            };return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            guard let data = data else{
                DispatchQueue.main.async {
                    dao.displayError(title: "Sorry", message: "We could't retrieve the movies at the time", view: view)
                }
                return
            }
            
            guard let movie = try? JSONDecoder().decode(MovieSearch.self, from: data) else {
                DispatchQueue.main.async {
                    dao.displayError(title: "Sorry", message: "We could't retrieve the movies at the time", view: view)
                }
                return
            }
            onCompletion(movie)
            
        }
        task.resume()
    }
    
    func retrieveImage(urlStr:String,onCompletion:@escaping(UIImage)->()){
        var placeholderImage:UIImage = UIImage(named: "image_not_found")!
        let urlString = urlStr
        
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            guard let data = data else{
                
                return
            }
            
            if let image:UIImage = UIImage(data: data) {
                placeholderImage = image
            }
            onCompletion(placeholderImage)
            
        }
        
        task.resume()
        
    }
    
    func retrieveCategories(urlStr:String,view:UIViewController,onCompletion:@escaping(GenreResult)->()){
        let urlString = urlStr
        
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                dao.displayError(title: "Sorry", message: "We could't retrieve the categories this time", view: view)
            };return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            guard let data = data else{
                DispatchQueue.main.async {
                    dao.displayError(title: "Sorry", message: "We could't retrieve the categories this time", view: view)
                }
                return
                
            }
            
            guard let genres = try? JSONDecoder().decode(GenreResult.self, from: data) else {
                DispatchQueue.main.async {
                    dao.displayError(title: "Sorry", message: "We could't retrieve the categories this time", view: view)
                }
                
                return
                
            }
            onCompletion(genres)
            
        }
        
        task.resume()
    }
    
}




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
    
    func retrieveCategories(urlStr:String,onCompletion:@escaping(GenreResult)->()){
       let urlString = urlStr
        
        guard let url = URL(string: urlString) else {fatalError("Could not retrieve random url")}
        
        let task = URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            guard let data = data else{
                
                fatalError("Could not retrieve data")
            }
            
            guard let genres = try? JSONDecoder().decode(GenreResult.self, from: data) else {
                fatalError("Failed to decode movie")
            
            }
            onCompletion(genres)
            
        }
        
        task.resume()
    }
    
    
    
    func saveFavorites() {
        do {
            try dao.favoriteMovies.save(inFileNamed: "favoritesJson")
        } catch {
            debugPrint("Cant save Player")
        }
    }

    func retrieveFavorites() {
        do {
            try dao.favoriteMovies.loadFrom(fileSystem: "favoritesJson")
        } catch {
            debugPrint("Cant load Player")
        }
    }
    
    
}

        
        
        
extension Encodable {

        /**
         Save information from the `Codable` Object.
         
         - Parameters:
            - file: Name of the file .
         
         - Throws:
        StorageError.failedToWrite
         
         */
        func save(inFileNamed file: String? = nil) throws {
            
            let fileName = file ?? String(describing: self)
            
            let url = URL(fileURLWithPath: (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent( fileName + ".json"))
            
            
            let data = try JSONEncoder().encode(self)
            
            do{
                try data.write(to: url)
            }catch{
                throw error
            }
        }
    }

extension Decodable {
        
        /**
         Loads information from the `Codable` Object from Domain.
         
         - Parameters:
            - fileSystem: Name of the file .
         
         - Throws:
         StorageError.failedToRead or StorageError.failedToDecode
         */
        mutating func loadFrom(fileSystem file: String? = nil) throws {
            
            let fileName = file ?? String(describing: self)
            let url = URL(fileURLWithPath: (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent( fileName + ".json"))
            
            try load(fromURL: url)
        }

    mutating func load(fromURL url: URL) throws {
          
          var readedData:Data!
          do {
              readedData = try Data(contentsOf: url)
          } catch  {
              throw error
          }
          do {
              self = try JSONDecoder().decode(Self.self, from: readedData)
          } catch {
              throw error
          }
      }
    
}


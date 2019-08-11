//
//  MovieParser.swift
//  Movs
//
//  Created by Henrique Campos de Freitas on 09/08/19.
//  Copyright © 2019 Henrique Campos de Freitas. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class MovieObject {
    let id: Int
    let title: String
    var posterPath: String
    var poster: Data? = nil
    var isFavorite: Bool = false
    
    init(id: Int, title: String, posterPath: String) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
    }
}

class MovieParser {
    static var managedObjectContext: NSManagedObjectContext? = nil
    static var movieEntity: NSEntityDescription? = nil
    
    class DecodableMovie: Decodable {
        let id: Int
        let title: String
        let poster_path: String
        let release_date: String
    }
    class DecodableMovies: Decodable {
        let results: Array<DecodableMovie>
    }
    
    static func parseAll(from data: Data) -> Array<MovieObject> {
        var movies: Array<MovieObject> = []
        
        /*DispatchQueue.main.sync {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            guard let movieEntity = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext) else { return }*/
            
            do {
                let decMovies = try JSONDecoder().decode(DecodableMovies.self, from: data)
                for decMovie in decMovies.results {
                    movies.append(MovieObject(id: decMovie.id, title: decMovie.title, posterPath: decMovie.poster_path))
                }
            } catch let error {
                print(error)
            }
        //}
        
        return movies
    }
}

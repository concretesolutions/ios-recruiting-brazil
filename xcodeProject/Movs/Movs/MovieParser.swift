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

class MovieParser {
    static var managedObjectContext: NSManagedObjectContext? = nil
    static var movieEntity: NSEntityDescription? = nil
    
    class DecodableMovie: Decodable {
        let title: String
        let poster_path: String
        let release_date: String
    }
    class DecodableMovies: Decodable {
        let results: Array<DecodableMovie>
    }
    
    static func parseAll(from data: Data) -> Array<Movie> {
        var movies: Array<Movie> = []
        
        DispatchQueue.main.sync {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            guard let movieEntity = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext) else { return }
            
            do {
                let decMovies = try JSONDecoder().decode(DecodableMovies.self, from: data)
                for decMovie in decMovies.results {
                    let movie = Movie(entity: movieEntity, insertInto: managedContext)
                    movie.attrName = decMovie.title
                    movie.attrCoverPath = decMovie.poster_path
                    movies.append(movie)
                }
            } catch let error {
                print(error)
                return
            }
        }
        
        return movies
    }
}

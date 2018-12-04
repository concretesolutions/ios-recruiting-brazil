//
//  GenrePersistanceHelper.swift
//  MoviesApp
//
//  Created by Thiago Borges Jordani on 04/12/18.
//  Copyright © 2018 Thiago Borges Jordani. All rights reserved.
//

import Foundation

class GenrePersistanceHelper {
    
    private init() {}
    
    class func getGenre() -> [Genre] {
        do {
            if let genres = try AppDelegate.shared
                .persistentContainer
                .viewContext
                .fetch(Genre.fetchRequest()) as? [Genre] {
                return genres
            }
            return []
        } catch {
            print("Fetching Failed")
            return []
        }
    }
    
    class func save(genreData: [String:Any]) {
        let genre = Genre(context: AppDelegate.shared.persistentContainer.viewContext)
        genre.id = Int64(Int(safeValue: genreData["id"]))
        genre.name = String(safeValue: genreData["name"])
        AppDelegate.shared.saveContext()
    }
}

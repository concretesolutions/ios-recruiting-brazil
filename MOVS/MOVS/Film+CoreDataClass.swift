//
//  Film+CoreDataClass.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 16/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Film)
public class Film: NSManagedObject {
    
    public convenience init(id: Int, overview: String?, posterPath: String?, releaseDate: String?, title: String?, genres: [Gener]?){
        let newFilm = NSEntityDescription.entity(forEntityName: "Film", in: CoreDataContextManager.shared.persistentContainer.viewContext)!
        self.init(entity: newFilm, insertInto: CoreDataContextManager.shared.persistentContainer.viewContext)
        
        self.id = Int32(id)
        self.overview = overview
        self.poster_path = posterPath
        self.release_date = releaseDate
        self.title = title
        let genresInCoreData = CoreDataManager<Gener>().fetch()
        for genre in genres ?? []{
            if !genresInCoreData.contains(where: { (genreCoreData) -> Bool in
                if genreCoreData.id == genre.id {
                    self.addToGeners(genreCoreData)
                    return true
                }
                return false
            }){
                if let name = genre.name {
                    let newGenre = Gener(id: genre.id, name: name)
                    self.addToGeners(newGenre)
                }
            }
        }
    }
}

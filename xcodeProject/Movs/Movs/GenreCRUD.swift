//
//  GenreCRUD.swift
//  Movs
//
//  Created by Henrique Campos de Freitas on 12/08/19.
//  Copyright © 2019 Henrique Campos de Freitas. All rights reserved.
//

import Foundation
import CoreData

class GenreCRUD {
    static var managedContext: NSManagedObjectContext? = nil
    
    static func fetch(byId id: Int) -> Genre? {
        let fetchRequest = NSFetchRequest<Genre>(entityName: "Genre")
        let predicate = NSPredicate(format: "attrId = \(id)")
        fetchRequest.predicate = predicate
        do {
            let results = try managedContext?.fetch(fetchRequest)
            return results?.first
        } catch let error as NSError {
            print(error)
            return nil
        }
    }
    
    static func add(from genreObject: GenreObject) {
        guard let managedContext = self.managedContext, let genreEntity = NSEntityDescription.entity(forEntityName: "Genre", in: managedContext) else { return }
        
        if self.fetch(byId: genreObject.id) == nil {
            let genre = Genre(entity: genreEntity, insertInto: managedContext)
            genre.attrId = Int32(genreObject.id)
            genre.attrName = genreObject.name
        }
    }
}

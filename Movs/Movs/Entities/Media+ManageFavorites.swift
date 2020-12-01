//
//  Media+ManageFavorites.swift
//  Movs
//
//  Created by Gabriel Coutinho on 01/12/20.
//

import Foundation
import CoreData

extension Media {
    func saveToFavorites(to context: NSManagedObjectContext) throws {
        let mediaEntity = NSEntityDescription.entity(forEntityName: "Media", in: context)!
        
        let media = NSManagedObject(entity: mediaEntity, insertInto: context)
        media.setValue(self.id, forKey: (\Media.id).stringValue)
        media.setValue(self.title, forKey: (\Media.title).stringValue)
        media.setValue(self.genreIds, forKey: (\Media.genreIds).stringValue)
        
    }
}

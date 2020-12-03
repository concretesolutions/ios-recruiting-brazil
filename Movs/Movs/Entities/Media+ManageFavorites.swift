//
//  Media+ManageFavorites.swift
//  Movs
//
//  Created by Gabriel Coutinho on 01/12/20.
//

import Foundation
import CoreData

extension Media {
    func salvarNosFavoritos(em context: NSObject) throws {
        let context = context as! NSManagedObjectContext
        
        let mediaEntity = NSEntityDescription.entity(forEntityName: "Media", in: context)!
        
        let media = NSManagedObject(entity: mediaEntity, insertInto: context)
        media.setValue(self.id, forKey: (\Media.id).stringValue)
        media.setValue(self.title, forKey: (\Media.title).stringValue)
        media.setValue(self.backdropPath, forKey: (\Media.backdropPath).stringValue)
        media.setValue(self.posterPath, forKey: (\Media.posterPath).stringValue)
    }
    
    func getFavoritos(em context: NSManagedObjectContext) -> [Int] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Media")

        // Helpers
        var result = [NSManagedObject]()

        do {
            // Execute Fetch Request
            let records = try context.fetch(fetchRequest)

            if let records = records as? [NSManagedObject] {
                result = records
            }

        } catch {
            debugPrint("Não consegui pegar os favoritos.")
            return []
        }
        
        let resultIds = result.compactMap { entity in entity.value(forKey: (\Media.id).stringValue) as? Int }

        return resultIds
    }
}

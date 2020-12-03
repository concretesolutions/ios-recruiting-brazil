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
        
        let mediaEntity = NSEntityDescription.entity(forEntityName: "MediaEntity", in: context)!
        
        let media = NSManagedObject(entity: mediaEntity, insertInto: context)
        media.setValue(Int32(self.id ?? 0), forKey: "id")
        media.setValue(self.title, forKey: "title")
        media.setValue(self.backdropPath, forKey: "backdropPath")
        media.setValue(self.posterPath, forKey: "posterPath")
        
        try context.save()
    }
    
    func removerDosFavoritos(_ filmeId: Int, em context: NSObject) throws {
        let context = context as! NSManagedObjectContext
        
        if let filme = fetchFavorito(filmeId, em: context) {
            context.delete(filme)
            try context.save()
        }
    }
    
    static func getIdsFavoritos(em context: NSObject) -> [Int] {
        let context = context as! NSManagedObjectContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MediaEntity")

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
        
        let resultIds = result.compactMap { entity in entity.value(forKey: "id") as? Int }

        return resultIds
    }
    
    private func fetchFavorito(_ filmeId: Int, em context: NSManagedObjectContext) -> NSManagedObject? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MediaEntity")

        var result: NSManagedObject?

        do {
            let records = try context.fetch(fetchRequest)
            result = records.first { (record) -> Bool in
                if let record = record as? NSManagedObject {
                    return (record.value(forKey: "id") as! Int) == filmeId
                } else {
                    return false
                }
            } as? NSManagedObject

        } catch {
            debugPrint("Não consegui pegar os favoritos.")
            return nil
        }

        return result
    }
}

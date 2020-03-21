//
//  GenresCoreData.swift
//  GenresFeature
//
//  Created by Marcos Felipe Souza on 20/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import CoreData

protocol GenresCoreDataType: AnyObject {
    func lastDateUpdate() -> Date?
    func fetchGenres() -> [GenreEntity]
    func removeAllGenres()
    func updateDate()
    func persist(with genreModels: [GenreModel])
}

class GenresCoreData: GenresCoreDataType {
    
    var managedObjectContext: NSManagedObjectContext?
    
    init() {
        do {
            let dataController = try DataController {}
            self.managedObjectContext = dataController.managedObjectContext
        } catch {
            self.managedObjectContext = nil
        }
    }
    
    func lastDateUpdate() -> Date? {
        var dateUpdate: Date? = nil
        guard let moc = self.managedObjectContext else {
            return dateUpdate
        }
        
        let fetch: NSFetchRequest<LastUpdateEntity> = LastUpdateEntity.fetchRequest()        
        do {
            try moc.save()
            let lastUpdate = try moc.fetch(fetch)
            dateUpdate = lastUpdate.first?.genre
        } catch let error as NSError {
            dateUpdate = nil
            debugPrint(" ===== Error ao Last Date Update ::: \(error.localizedDescription)")
        }
        return dateUpdate
    }
    
    func lastDateUpdate(handle: @escaping (_ date: Date?)->() ) {
        DispatchQueue.main.async {
            guard let moc = self.managedObjectContext else {
                handle(nil)
                return
            }
            
            let fetch: NSFetchRequest<LastUpdateEntity> = LastUpdateEntity.fetchRequest()
            do {
                try moc.save()
                let lastUpdate = try moc.fetch(fetch)
                handle(lastUpdate.first?.genre)
                
            } catch let error as NSError {
                handle(nil)
                debugPrint(" ===== Error ao Last Date Update ::: \(error.localizedDescription)")
            }
        }
    }

    func fetchGenres() -> [GenreEntity] {
        let fetch: NSFetchRequest<GenreEntity> = GenreEntity.fetchRequest()
        do {
            let genres = try managedObjectContext?.fetch(fetch)
            return genres ?? []
        } catch {
            return []
        }
    }
    
    func removeAllGenres() {
        
        guard let moc = managedObjectContext else { return }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GenreEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            let result = try moc.execute(deleteRequest)
            debugPrint(result.debugDescription)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
    func updateDate() {
        guard let context = self.managedObjectContext else { return }
        let fetch: NSFetchRequest<LastUpdateEntity> = LastUpdateEntity.fetchRequest()
        do {
            let updateDate = try context.fetch(fetch)
            if updateDate.isEmpty {
                let lastUpdate = LastUpdateEntity(context: context)
                lastUpdate.genre = Date()
            
            } else {
                updateDate.first?.genre = Date()
            }
            try context.save()
        } catch let error {
            debugPrint("Error ao Update de Data \(error.localizedDescription) ")
        }
    }
    
    func persist(with genreModels: [GenreModel]) {
        guard let context = self.managedObjectContext else { return }
        genreModels.forEach { model in
            let genryEntity = GenreEntity(context: context)
            let idNumber = NSNumber(integerLiteral: model.id)
            genryEntity.id = idNumber.int64Value
            genryEntity.value = model.name
        }
        do {
            try context.save()
        } catch {
            debugPrint("Error ao persistir ::: \(error.localizedDescription)")
        }
    }
}

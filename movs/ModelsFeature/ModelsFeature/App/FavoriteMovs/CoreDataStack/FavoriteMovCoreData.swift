//
//  FavoriteMovCoreData.swift
//  ModelsFeature
//
//  Created by Marcos Felipe Souza on 22/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import CoreData
import CommonsModule


open class FavoriteMovCoreData {
    
    var managedObjectContext: NSManagedObjectContext?
    
    public init() {
        do {
            let bundle = Bundle(for: FavoriteMovCoreData.self)
            let dataController = try DataController(modelName: "ModelsFeature", bundle: bundle) {}
            self.managedObjectContext = dataController.managedObjectContext
        } catch {
            self.managedObjectContext = nil
        }
    }
    
    public func saveFavoriteMovs(model: FavoriteMovsModel) {
        guard let context = self.managedObjectContext else { return }
        let favoriteMovsEntity = FavoriteMovsEntity(context: context)
        favoriteMovsEntity.fill(with: model)
        do {
            try context.save()
        } catch {
            debugPrint("Error ao persistir ::: \(error.localizedDescription)")
        }
    }
    
    public func fetchFavoriteMovs() -> [FavoriteMovsModel] {
        guard let context = self.managedObjectContext else { return [] }
        let fetchRequest:NSFetchRequest<FavoriteMovsEntity> = FavoriteMovsEntity.fetchRequest()
        do {
            let favoriteMovsEntities = try context.fetch(fetchRequest)
            let favoriteMovsModels: [FavoriteMovsModel] = favoriteMovsEntities.compactMap {
                var model = FavoriteMovsModel()
                model.fill(with: $0)
                return model
            }
            
            return favoriteMovsModels
        } catch {
            debugPrint("Error ao fetchFavoriteMovs ::: \(error.localizedDescription)")
            return []
        }
    }
    
    public func deleteFavoriteMovs(model: FavoriteMovsModel) {
        guard let context = self.managedObjectContext else { return }
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovsEntity")
        
        let predicates: [NSPredicate] = self.createFullPredicate(with: model)
        fetch.predicate = NSCompoundPredicate(type: .and, subpredicates: predicates)
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        do {
            try context.execute(request)
        } catch {
            debugPrint("Error ao deleteFavoriteMovs ::: \(error.localizedDescription)")
        }
    }
    
    public func search(by model: FavoriteMovsModel) -> FavoriteMovsModel? {
        guard let moc = self.managedObjectContext else { return nil }
        let fetch: NSFetchRequest<FavoriteMovsEntity> = FavoriteMovsEntity.fetchRequest()
        let predicates = self.createFullPredicate(with: model)
        fetch.predicate = NSCompoundPredicate(type: .and, subpredicates: predicates)
        do {
            guard let entity = try moc.fetch(fetch).first else { return nil }
            var model = FavoriteMovsModel()
            model.fill(with: entity)
            return model
        } catch {
            debugPrint("Error ao search(by ::: \(error.localizedDescription)")
            return nil
        }
    }
}

extension FavoriteMovCoreData {
    private func createFullPredicate(with model: FavoriteMovsModel) -> [NSPredicate] {
        var predicates: [NSPredicate] = []
        
        if let title = model.title {
            predicates.append(NSPredicate(format: "title == %@", title))
        }
        if let owerview = model.owerview {
            predicates.append(NSPredicate(format: "owerview == %@", owerview))
        }
        if let year = model.year {
            predicates.append(NSPredicate(format: "year == %@", year))
        }
        return predicates
    }
}

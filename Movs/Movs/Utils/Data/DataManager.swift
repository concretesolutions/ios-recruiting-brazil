//
//  DataManager.swift
//  Movs
//
//  Created by Marcos Lacerda on 17/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import CoreData
import Foundation

class DataManager: NSObject {
  
  static let shared = DataManager()
  var favedMovies = [Int]()
  
  override internal init() {}
  
  fileprivate lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Movs")

    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })

    return container
  }()
  
  fileprivate func loadEntity(entityName: String, context: NSManagedObjectContext) -> NSEntityDescription {
    guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
      fatalError("Unresolved entity name: \(entityName)")
    }

    return entity
  }
  
  
  // Data manipulation
  
  func faved(with movie: Movies, callback: ((Result<Bool>) -> Void)) {
    let managedContext = self.persistentContainer.viewContext
    let entity = self.loadEntity(entityName: "Faved", context: managedContext)
    let faved = NSManagedObject(entity: entity, insertInto: managedContext)
    
    faved.setValue(movie.id, forKey: "id")
    
    do {
      try managedContext.save()

      // Insert id in faved list loaded
      self.favedMovies.append(movie.id)

      callback(.success(true))
    } catch let error as NSError {
      debugPrint("Could not save. \(error), \(error.userInfo)")
      callback(.error("saved-faved-error".localized()))
    }
  }
  
  func unfaved(with id: Int, callback: @escaping ((Bool) -> Void)) {
    let managedContext = self.persistentContainer.viewContext
    let fetchRequest: NSFetchRequest<Faved> = Faved.fetchRequest()
    var favedFetched = false
    
    fetchRequest.predicate = NSPredicate.init(format: "id==\(id)")
    
    if let result = try? managedContext.fetch(fetchRequest) {
      for object in result {
        managedContext.delete(object)
        try? managedContext.save()

        favedFetched = true
      }
    }
    
    // Remove id in faved list loaded
    if let index = favedMovies.firstIndex(of: id) {
      self.favedMovies.remove(at: index)
    }
    
    callback(favedFetched)
  }
  
  func loadFavedMovies(_ callback: @escaping (() -> Void)) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Faved")
    let managedContext = self.persistentContainer.viewContext
    
    do {
      let results = try managedContext.fetch(fetchRequest)
      let items = results as! [NSManagedObject]

      for item in items {
        if let favedID = item.value(forKey: "id") as? Int {
          favedMovies.append(favedID)
        }
      }
    } catch {
      debugPrint("Error is retriving faved items")
    }
    
    callback()
  }
  
}

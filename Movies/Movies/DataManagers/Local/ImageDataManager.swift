//
//  ImageDataManager.swift
//  Movies
//
//  Created by Renan Germano on 19/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit
import CoreData

class ImageDataManager {
    
    // MARK: - Aux functions
    
    private static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Movies")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private static let context = persistentContainer.viewContext
    
    private static func saveContext() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Image
    
    private struct ImageModel {
        static let entityName = "ImageModel"
        static let posterPath = "poster_path"
        static let content = "content"
    }
    
    static func managedObject(posterPath: String, image: UIImage) -> NSManagedObject? {
        if let entity = NSEntityDescription.entity(forEntityName: ImageModel.entityName, in: context) {
            let object = NSManagedObject(entity: entity, insertInto: context)
            object.setValue(posterPath, forKey: ImageModel.posterPath)
            object.setValue(image.jpegData(compressionQuality: 1), forKey: ImageModel.content)
            saveContext()
            return object
        }
        return nil
    }
    
    static func image(_ mo: NSManagedObject) -> UIImage? {
        if let imageData = mo.value(forKey: ImageModel.content) as? Data,
            let image = UIImage(data: imageData) {
            return image
        }
        return nil
    }
    
    static func saveImage(posterPath: String, image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 1) {
            if let entity = NSEntityDescription.entity(forEntityName: ImageModel.entityName, in: context) {
                let imageObject = NSManagedObject(entity: entity, insertInto: context)
                imageObject.setValue(posterPath, forKey: ImageModel.posterPath)
                imageObject.setValue(imageData, forKey: ImageModel.content)
                saveContext()
            }
        }
        
    }
    
    static func readImage(withPosterPath posterPath: String) -> UIImage? {
        let imageRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ImageModel.entityName)
        imageRequest.returnsObjectsAsFaults = false
        imageRequest.predicate = NSPredicate(format: "\(ImageModel.posterPath) == %@", posterPath)
        do {
            let result = try context.fetch(imageRequest)
            if let mos = result as? [NSManagedObject] {
                if mos.count > 0 {
                    if let imageData = mos.first!.value(forKey: ImageModel.content) as? Data {
                        return UIImage(data: imageData)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    static func deleteImage(withPosterPath posterPath: String) {
        let imageRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ImageModel.entityName)
        imageRequest.returnsObjectsAsFaults = false
        imageRequest.predicate = NSPredicate(format: "\(ImageModel.posterPath) == %@", posterPath)
        do {
            let result = try context.fetch(imageRequest)
            if let mos = result as? [NSManagedObject] {
                if mos.count > 0 {
                    context.delete(mos.first!)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        saveContext()
    }
    
}

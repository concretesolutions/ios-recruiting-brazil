//
//  DataBase.swift
//  Movs
//
//  Created by Pedro Clericuzi on 21/12/2018.
//  Copyright © 2018 Pedro Clericuzi. All rights reserved.
//
import UIKit
import CoreData

class DataBase {
    
    func initCoreData() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let context = appDelegate.persistentContainer.viewContext;
        return context;
    }
    
    func saveFavorite(id:String) {
        let context = initCoreData();
        do {
            let objManagement = NSEntityDescription.insertNewObject(forEntityName: "Favorite", into: context);
            objManagement.setValue(id, forKey: "id");
            try context.save();
        } catch {
            print("Fatal error to register the taks");
        }
    }
    
    
    func getFavorite() -> [NSManagedObject] {
        let context = initCoreData();
        let requisition = NSFetchRequest<NSFetchRequestResult>(entityName:"Favorite");
        let sort = NSSortDescriptor(key: "id", ascending: true);
        requisition.sortDescriptors = [sort];
        var allFavorites:[NSManagedObject]?;
        do{
            allFavorites = try context.fetch(requisition) as! [NSManagedObject];
        }catch let error as NSError{
            print("Ocurred a fatal error: \(error.description) ");
        }
        return allFavorites!;
    }
    
    func getSpecificFavorite(value:String) -> [NSManagedObject] {
        let context = initCoreData();
        let requisition = NSFetchRequest<NSFetchRequestResult>(entityName:"Favorite");
        let sort = NSSortDescriptor(key: "id", ascending: true); //order by category
        requisition.predicate = NSPredicate(format: "id == %@", value);
        requisition.sortDescriptors = [sort];
        var myFavorite:[NSManagedObject]?;
        do{
            myFavorite = try context.fetch(requisition) as? [NSManagedObject];
        }catch let error as NSError{
            print("Ocurred a fatal error: \(error.description) ");
        }
        return myFavorite!;
    }
    
    func deleteFavorite(id:String) {
        let context = initCoreData();
        let requisition = NSFetchRequest<NSFetchRequestResult>(entityName:"Favorite");
        requisition.predicate = NSPredicate(format: "id == %@", id);
        var allFavorites:[NSManagedObject]?;
        do{
            allFavorites = try context.fetch(requisition) as! [NSManagedObject];
            for managedObject in allFavorites!
            {
                context.delete(managedObject);
            }
            try context.save();
        }catch let error as NSError{
            print("Ocurred a fatal error: \(error.description) ");
        }
    }
}

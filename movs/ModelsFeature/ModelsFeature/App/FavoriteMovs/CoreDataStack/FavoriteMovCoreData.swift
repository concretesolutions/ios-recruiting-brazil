//
//  FavoriteMovCoreData.swift
//  ModelsFeature
//
//  Created by Marcos Felipe Souza on 22/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import CoreData
import CommonsModule


class FavoriteMovCoreData {
    
    var managedObjectContext: NSManagedObjectContext?
    
    init() {
        do {
            let bundle = Bundle(for: FavoriteMovCoreData.self)
            let dataController = try DataController(modelName: "ModelsFeature", bundle: bundle) {}
            self.managedObjectContext = dataController.managedObjectContext
        } catch {
            self.managedObjectContext = nil
        }
    }
    
    func saveFavoriteMovs() {
        
    }
    
    func fetchFavoriteMovs() {
        
    }
    
    func deleteFavoriteMovs() {
        
    }
}

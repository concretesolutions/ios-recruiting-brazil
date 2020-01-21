//
//  CoreDataDelegate.swift
//  Movs
//
//  Created by Rafael Douglas on 20/01/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import UIKit
import CoreData

class CoreDataDelegate: UIViewController {
    class func movieWasAdded(movie:Movie) -> Bool{
        if let movieId = movie.id{
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false}
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest: NSFetchRequest<Movies> = Movies.fetchRequest()
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(String(movieId))")
            do {
                let moviesAdded = try managedContext.fetch(fetchRequest)
                return moviesAdded.count > 0
            } catch let error as NSError {
                print("erro \(error)")
            }
            
        }
        return false
    }
}

//
//  Favorite+CoreDataClass.swift
//  
//
//  Created by Adann Simões on 17/11/18.
//
//

import Foundation
import CoreData

public class Favorite: NSManagedObject {
    @NSManaged public var releaseDate: NSDate?
    @NSManaged public var overview: String?
    @NSManaged public var adult: Bool
    @NSManaged public var backdropPath: String?
    @NSManaged public var genres: String?
    @NSManaged public var originalTitle: String?
    @NSManaged public var originalLanguage: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var popularity: Double
    @NSManaged public var title: String?
    @NSManaged public var voteAverage: Double
    @NSManaged public var video: Bool
    @NSManaged public var id: Int32
    @NSManaged public var voteCount: Int32
    
    convenience init() {
        // get context
        let managedObjectContext: NSManagedObjectContext =
            CoreDataManager.sharedInstance.persistentContainer.viewContext
        
        // create entity description
        let entityDescription = NSEntityDescription.entity(forEntityName: "Favorite", in: managedObjectContext)
        
        // call super
        self.init(entity: entityDescription!, insertInto: nil)
        
    }
}

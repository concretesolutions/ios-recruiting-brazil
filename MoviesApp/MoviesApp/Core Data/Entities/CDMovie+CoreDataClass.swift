//
//  CDMovie+CoreDataClass.swift
//  
//
//  Created by Nicholas Babo on 13/11/18.
//
//

import Foundation
import CoreData

@objc(CDMovie)
public class CDMovie: NSManagedObject {

    static func newMovie() -> CDMovie{
        return NSEntityDescription.insertNewObject(forEntityName: PersistedEntity.movie, into: DatabaseManager.getContext()) as! CDMovie
    }
    
}

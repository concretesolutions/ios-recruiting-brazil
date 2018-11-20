//
//  Film+CoreDataProperties.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 16/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//
//

import Foundation
import CoreData


extension Film {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Film> {
        return NSFetchRequest<Film>(entityName: "Film")
    }
    
    @NSManaged public var id: Int32
    @NSManaged public var overview: String?
    @NSManaged public var poster_path: String?
    @NSManaged public var release_date: String?
    @NSManaged public var title: String?
    @NSManaged public var geners: NSSet?

}

// MARK: Generated accessors for geners
extension Film {

    @objc(addGenersObject:)
    @NSManaged public func addToGeners(_ value: Gener)

    @objc(removeGenersObject:)
    @NSManaged public func removeFromGeners(_ value: Gener)

    @objc(addGeners:)
    @NSManaged public func addToGeners(_ values: NSSet)

    @objc(removeGeners:)
    @NSManaged public func removeFromGeners(_ values: NSSet)

}

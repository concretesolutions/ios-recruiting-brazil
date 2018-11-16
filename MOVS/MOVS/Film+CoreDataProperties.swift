//
//  Film+CoreDataProperties.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 15/11/18.
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
    @NSManaged public var title: String?
    @NSManaged public var overview: String?
    @NSManaged public var poster_path: String?
    @NSManaged public var release_date: String?
    @NSManaged public var have: NSSet?

}

// MARK: Generated accessors for have
extension Film {

    @objc(addHaveObject:)
    @NSManaged public func addToHave(_ value: Gener)

    @objc(removeHaveObject:)
    @NSManaged public func removeFromHave(_ value: Gener)

    @objc(addHave:)
    @NSManaged public func addToHave(_ values: NSSet)

    @objc(removeHave:)
    @NSManaged public func removeFromHave(_ values: NSSet)

}

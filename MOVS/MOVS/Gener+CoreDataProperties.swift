//
//  Gener+CoreDataProperties.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 16/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//
//

import Foundation
import CoreData


extension Gener {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Gener> {
        return NSFetchRequest<Gener>(entityName: "Gener")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var films: NSSet?

}

// MARK: Generated accessors for films
extension Gener {

    @objc(addFilmsObject:)
    @NSManaged public func addToFilms(_ value: Film)

    @objc(removeFilmsObject:)
    @NSManaged public func removeFromFilms(_ value: Film)

    @objc(addFilms:)
    @NSManaged public func addToFilms(_ values: NSSet)

    @objc(removeFilms:)
    @NSManaged public func removeFromFilms(_ values: NSSet)

}

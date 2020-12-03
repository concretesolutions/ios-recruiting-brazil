//
//  Media+CoreDataProperties.swift
//  Movs
//
//  Created by Gabriel Coutinho on 02/12/20.
//
//

import Foundation
import CoreData


extension Media {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Media> {
        return NSFetchRequest<Media>(entityName: "Media")
    }

    @NSManaged public var id: Int16
    @NSManaged public var title: String?
    @NSManaged public var backdropPath: String?
    @NSManaged public var posterPath: String?

}

extension Media : Identifiable {

}

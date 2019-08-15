//
//  Genre+CoreDataProperties.swift
//  
//
//  Created by Tiago Chaves on 14/08/19.
//
//

import Foundation
import CoreData


extension Genre {

    @nonobjc public class func genreFetchRequest() -> NSFetchRequest<Genre> {
        return NSFetchRequest<Genre>(entityName: "Genre")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
}

//
//  Gener+CoreDataProperties.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 15/11/18.
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
    @NSManaged public var isPart: Film?

}

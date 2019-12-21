//
//  Genre+CoreDataClass.swift
//  
//
//  Created by Marcos Santos on 19/12/19.
//
//

import Foundation
import CoreData

@objc(Genre)
public class Genre: NSManagedObject, Decodable {

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }

    // MARK: Codable

    required convenience public init(from decoder: Decoder) throws {
        try self.init(saving: false)

        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(Int64.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }

    func insertIntoContext() throws {
        if !self.isInserted {
            let context = try CoreDataManager.getContext()
            context.insert(self)
        }
    }
}

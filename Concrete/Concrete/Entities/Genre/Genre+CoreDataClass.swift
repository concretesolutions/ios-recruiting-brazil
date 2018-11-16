//
//  Genre+CoreDataClass.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 12/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Genre)
public class Genre: NSManagedObject,Decodable {
    //
    private enum Keys:String,CodingKey {
        case id
        case name
    }
    
    // MARK: Decodable
    public convenience required init(from decoder: Decoder) throws {
        
        // Create NSEntityDescription with NSManagedObjectContext
        //        guard let contextUserInfoKey = CodingUserInfoKey.context else {
        //            Logger.logError(in: Character.self, message: "Failed to get CodingUserInfoKey")
        //            throw Erros.couldNotInstance
        //        }
        
        
        guard let managedObjectContext = decoder.userInfo[.context] as? NSManagedObjectContext else {
            Logger.logError(in: Genre.self, message: "Failed to cast to NSManagedObjectContext")
            throw Erros.couldNotInstance
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "Genre", in: managedObjectContext) else {
            Logger.logError(in: Genre.self, message: "Failed to instance NSEntityDescription")
            throw Erros.couldNotInstance
        }
        
        self.init(entity: entity, insertInto: nil)
        
        let container = try decoder.container(keyedBy: Keys.self)
        
        //ID
        self.id = try container.decode(Int32.self, forKey: .id)
        
        //Name
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
    }
}

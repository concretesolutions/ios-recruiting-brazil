//
//  Gener+CoreDataClass.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 16/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Gener)
public class Gener: NSManagedObject, Decodable {
    //MARK:- Descodable Keys
    enum CodingKeysGener: String, CodingKey {
        case id
        case name
    }
    
    public convenience init(id: Int32, name: String){
        let newGenre = NSEntityDescription.entity(forEntityName: "Gener", in: CoreDataContextManager.shared.persistentContainer.viewContext)!
        self.init(entity: newGenre, insertInto: CoreDataContextManager.shared.persistentContainer.viewContext)
        
        self.id = id
        self.name = name
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let genre = NSEntityDescription.entity(forEntityName: "Gener", in: CoreDataContextManager.shared.persistentContainer.viewContext) else {
            print("Error trying to decode an Genre")
            self.init()
            return
        }
        
        self.init(entity: genre, insertInto: nil)
        
        //Decode
        let container = try decoder.container(keyedBy: CodingKeysGener.self)
        guard let int = try container.decodeIfPresent(Int.self, forKey: .id) else {
            print("Error trying to get genre ID")
            return
        }
        self.id = Int32(int)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        
    }
}

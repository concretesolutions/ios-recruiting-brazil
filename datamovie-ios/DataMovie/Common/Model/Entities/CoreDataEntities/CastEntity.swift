//
//  CastEntity.swift
//  DataMovie
//
//  Created by Andre Souza on 29/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation
import CoreData

enum GenderType: Int {
    case none, woman, man
}

@objc(CastEntity)
public class CastEntity: NSManagedObject, FetchableProtocol {
    
    @NSManaged public var creditID: String?
    @NSManaged public var personID: Int32
    @NSManaged public var gender: Int32
    @NSManaged public var name: String
    @NSManaged public var profilePicture: String?
    @NSManaged public var character: String?
    @NSManaged public var order: Int32
    @NSManaged public var movies: Set<MovieEntity>
    
}

// MARK: Generated accessors for movies

extension CastEntity {
    
    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: MovieEntity)
    
    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: MovieEntity)
    
    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: Set<MovieEntity>)
    
    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: Set<MovieEntity>)
    
}

// MARK: Custom type

extension CastEntity {
    
    var genderType: GenderType {
        get {
            if let mGender = GenderType(rawValue: Int(gender)) {
                return mGender
            }
            return .none
        }
    }
    
}

// MARK: - Custom init -

extension CastEntity {
    
    convenience init?(with model: CastModel) {
        
        guard
            let personID = model.personID,
            let name = model.name
        else {
            return nil
        }
        
        self.init()
        
        self.creditID = model.creditID
        self.personID = Int32(personID)
        self.order = Int32((model.order ?? 0))
        self.name = name
        
        self.gender = Int32(model.gender ?? 0)
        self.profilePicture = model.profilePicture
        self.character = model.character
        
    }
    
    convenience private init() {
        self.init(context: CoreDataStack.sharedInstance.persistentContainer.viewContext)
    }
    
}

//
//  Factory.swift
//  Movs
//
//  Created by Franclin Cabral on 1/18/19.
//  Copyright © 2019 franclin. All rights reserved.
//

import Foundation

public typealias PropertyValuePair = (name: String, value: Any)
public protocol PropertyValueType {
    var propertyValuePair: PropertyValuePair { get }
}

enum DefaultPropertyValue: PropertyValueType {
    var propertyValuePair: PropertyValuePair {
        return ("", 0)
    }
}

protocol QueryType {
    associatedtype Descriptor
    var predicate: NSPredicate? { get }
    var sortDescriptors: [Descriptor] { get }
}

protocol DataStoreProtocol {
    func create<T>(_ value: T, update: Bool) throws where T : Persistable
    func saveRealmArray<T>(_ objects: [T]) throws where T: Persistable
    func read<T>(_ type: T.Type, matching query: T.Query?) -> [T] where T : Persistable
    func delete<T>(_ value: T) throws where T : Persistable 
}

protocol FactoryProtocol {
    var networking: NetworkingProtocol { get }
    var dataStore: DataStoreProtocol { get }
}

class FactoryBuilder {
    typealias FactoryBuilderClosure = (FactoryBuilder) -> ()
    
    var networking: NetworkingProtocol!
    var dataStore: DataStoreProtocol!
    
    init(builder: FactoryBuilderClosure) {
        builder(self)
    }
}

class Factory: FactoryProtocol {
    var networking: NetworkingProtocol
    var dataStore: DataStoreProtocol
    
    init(builder: FactoryBuilder) {
        self.networking = builder.networking
        self.dataStore = builder.dataStore
    }
}

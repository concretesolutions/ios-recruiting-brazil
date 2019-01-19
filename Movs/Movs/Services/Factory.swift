//
//  Factory.swift
//  Movs
//
//  Created by Franclin Cabral on 1/18/19.
//  Copyright © 2019 franclin. All rights reserved.
//

import Foundation

protocol DataStoreProtocol { }

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

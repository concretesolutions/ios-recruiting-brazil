//
//  ManagerCenter.swift
//  Movs
//
//  Created by Franclin Cabral on 1/18/19.
//  Copyright © 2019 franclin. All rights reserved.
//

import Foundation


typealias ManagerConfiguration = (factory: FactoryProtocol, router: RouterProtocol)


class ManagerCenter {
    static let shared: ManagerCenter = ManagerCenter()
    
    private(set) var factory: FactoryProtocol
    var router: RouterProtocol
    private static var configuration: ManagerConfiguration?
    
    class func configure(config: ManagerConfiguration) {
        ManagerCenter.configuration = config
    }
    
    private init() {
        let configuration = ManagerCenter.configuration
        guard let config = configuration else {
            fatalError("Error - you must call setup before accessing ManagerCenter.shared")
        }
        factory = config.factory
        router = config.router
    }
}

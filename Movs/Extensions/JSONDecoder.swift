//
//  JSONDecoder.swift
//  Movs
//
//  Created by Gabriel D'Luca on 12/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation

extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, resourceName: String, resourceType: String, bundle: Bundle = Bundle.main) throws -> T {
        let path = bundle.path(forResource: resourceName, ofType: resourceType)!
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let decodedObject = try self.decode(type, from: data)
        
        return decodedObject
    }
}

//
//  Extensions.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 10/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import Foundation

extension Array {
    
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        
        return self[index]
    }
}

extension Array where Element == Genre {
    var description: String {
        return self.map { $0.name }.joined(separator: ", ")
    }
}

extension URL {
    public init(safeString string: String) {
        guard let instance = URL(string: string) else {
            fatalError("Unconstructable URL: \(string)")
        }
        self = instance
    }
}

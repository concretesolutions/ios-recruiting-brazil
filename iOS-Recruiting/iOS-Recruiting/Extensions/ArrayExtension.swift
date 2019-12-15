//
//  ArrayExtension.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 15/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import Foundation

extension Array {
    
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>()
        var arrayOrdered = [Element]()
        
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }
        
        return arrayOrdered
    }
    
}

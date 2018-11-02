//
//  ArrayHelper.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 02/11/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            if !uniqueValues.contains(item) {
                uniqueValues += [item]
            }
        }
        return uniqueValues
    }
}

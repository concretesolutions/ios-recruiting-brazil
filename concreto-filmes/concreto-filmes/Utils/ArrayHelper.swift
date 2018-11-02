//
//  ArrayHelper.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 02/11/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    var unique: [Element] {
        return Array(Set(self))
    }
}

//
//  String.swift
//  Movs
//
//  Created by Dielson Sales on 08/10/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit

extension String {

    static func join(_ strings: [String], withSeparator separator: String) -> String {
        var finalString = ""
        for index in (0 ..< strings.count) {
            finalString.append("\(strings[index])")
            if index < strings.endIndex - 1 {
                finalString.append(separator)
            }
        }
        return finalString
    }
}

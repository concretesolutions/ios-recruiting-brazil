//
//  KeyPath+stringValue.swift
//  Movs
//
//  Created by Gabriel Coutinho on 01/12/20.
//

import Foundation

extension KeyPath where Root == Media {
    var stringValue: String {
        NSExpression(forKeyPath: self).keyPath
    }
}

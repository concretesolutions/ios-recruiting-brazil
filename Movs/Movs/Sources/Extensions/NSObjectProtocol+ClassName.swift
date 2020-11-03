//
//  NSObjectProtocol+ClassName.swift
//  Movs
//
//  Created by Adrian Almeida on 26/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Foundation

extension NSObjectProtocol {
    static var className: String {
        return String(describing: Self.self)
    }
}

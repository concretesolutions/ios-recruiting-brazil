//
//  NSCoder+Extension.swift
//  MovsTests
//
//  Created by Adrian Almeida on 03/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Foundation

extension NSCoder {
    static let empty: NSCoder = NSKeyedUnarchiver(forReadingWith: Data())
}

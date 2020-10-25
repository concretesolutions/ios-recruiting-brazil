//
//  Data+Extension.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Foundation

extension Data {
    var string: String {
        return String(data: self, encoding: .utf8) ?? Strings.errorParseDataToString.localizable
    }
}

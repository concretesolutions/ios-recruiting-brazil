//
//  TargetType+Environment.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 01/10/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import Moya

extension TargetType {
    var environment: Environment {
        return Environment.load()
    }
}

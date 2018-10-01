//
//  Environment.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 01/10/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import Mapper

struct Environment: Mappable {
    var baseUrl: String
    var apiKey: String
    
    init(map: Mapper) throws {
        try baseUrl = map.from("baseUrl")
        try apiKey = map.from("apiKey")
    }
}

extension Environment {
    public static func load() -> Environment {
        guard let envDic = Bundle.main.infoDictionary?["Environment"] as? NSDictionary else {
            fatalError("there isn't environment defined in info.plist")
        }
        guard let envi = Environment.from(envDic) else {
            fatalError("couldn’t be completed parse \(envDic.description) to Environment")
        }
        return envi
    }
}

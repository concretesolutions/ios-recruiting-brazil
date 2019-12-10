//
//  Environment.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 10/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import Foundation
import ObjectMapper

class HostsObject: Mappable {
    
    var base: String?
    var movieDB: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        self.base  <- map["Base"]
        self.movieDB <- map["movieDB"]
    }
}

class KeysObject: Mappable {
    
    var movieDBKEY: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        self.movieDBKEY <- map["movieDBKEY"]
    }
    
}

class EnvironmentUtil {
    
    static var environment: [String : Any]? {
       return Bundle.main.infoDictionary?["LSEnvironment"] as? [String : Any] ?? [:]
   }
    
    static var hosts: HostsObject? {
        let JSON = EnvironmentUtil.environment?["Hosts"] as? [String : Any] ?? [:]
        return HostsObject(JSON: JSON)
    }
    
    static var keys: KeysObject? {
        let JSON = EnvironmentUtil.environment?["Keys"] as? [String : Any] ?? [:]
       return KeysObject(JSON: JSON)
   }
    
}

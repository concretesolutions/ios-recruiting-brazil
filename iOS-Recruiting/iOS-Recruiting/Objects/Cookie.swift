//
//  Cookie.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 15/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import Foundation

class Cookie {
    
    static let shared = Cookie()
        
    internal func get(_ name: String) -> HTTPCookie? {
        let cookies = HTTPCookieStorage.shared.cookies?.filter { $0.name.contains(name) } ?? []
        let filtered = cookies.filter { $0.expiresDate ?? Date() > Date() }
        let sorted = filtered.sorted { $0.expiresDate ?? Date() < $1.expiresDate ?? Date() }
        return sorted.last
    }
    
    internal func set(_ name: String, values: [String : Any], expires: Date) {
        let JSON = values.toJSONString() ?? ""
        let domain = Bundle.main.bundleIdentifier ?? ""
        
        let properties: [HTTPCookiePropertyKey : Any] = [.name : name,
                                                         .secure : true,
                                                         .value : JSON,
                                                         .path : "/",
                                                         .expires : expires,
                                                         .domain: domain]
        
        if let cookie = HTTPCookie(properties: properties) {
            HTTPCookieStorage.shared.setCookie(cookie)
        } else {
            Log.shared.show(error: "HTTPCookie \(name) - creation failed")
        }
    }

    internal func delete(_ name: String) {
        if let cookie = HTTPCookieStorage.shared.cookies?.first(where: { $0.name == name }) {
            HTTPCookieStorage.shared.deleteCookie(cookie)
        } else {
            Log.shared.show(error: "HTTPCookie \(name) - delete failed")
        }
    }

    internal func deleteAll() {
        HTTPCookieStorage.shared.cookies?.forEach {
            HTTPCookieStorage.shared.deleteCookie($0)
        }
    }

}

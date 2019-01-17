//
//  Settings.swift
//  Movs
//
//  Created by vinicius emanuel on 17/01/19.
//  Copyright © 2019 vinicius emanuel. All rights reserved.
//

import Foundation

fileprivate let POSTER_SIZE_KEY = "poster_size_key"
fileprivate let BASE_URL_KEY = "base_url_key"

class Settins {
    static let defaults = UserDefaults.standard
    
    class func savePosterSize(size: String) {
        defaults.set(size, forKey: POSTER_SIZE_KEY)
    }
    
    class func getPosterSize() -> String? {
        guard let size = defaults.string(forKey: POSTER_SIZE_KEY) else {
            return nil
        }
        return size
    }
    
    
    class func saveBaseUrl(baseUrl: String) {
        defaults.set(baseUrl, forKey: BASE_URL_KEY)
    }
    
    class func getBaseUrl() -> String? {
        guard let baseUrl = defaults.string(forKey: BASE_URL_KEY) else {
            return nil
        }
        return baseUrl
    }
}

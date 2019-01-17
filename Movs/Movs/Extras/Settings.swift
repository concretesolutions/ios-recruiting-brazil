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
    var posterSize: String?{
        get{
            let defaults = UserDefaults.standard
            guard let size = defaults.string(forKey: POSTER_SIZE_KEY) else{
                return nil
            }
            return size
        }
        set(value){
            let defaults = UserDefaults.standard
            defaults.set(value, forKey: POSTER_SIZE_KEY)
        }
    }
    
    var baseUrl: String?{
        get{
            let defaults = UserDefaults.standard
            guard let url = defaults.string(forKey: BASE_URL_KEY) else{
                return nil
            }
            return url
        }
        set(value){
            let defaults = UserDefaults.standard
            defaults.set(value, forKey: BASE_URL_KEY)
        }
    }
    
    init(posterSize: String, baseUrl: String){
        self.posterSize = posterSize
        self.baseUrl = baseUrl
    }
}

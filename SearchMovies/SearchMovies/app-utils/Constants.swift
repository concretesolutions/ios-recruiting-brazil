//
//  Constants.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 07/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

struct Constants {
    static let appKey:String = (Bundle.main.infoDictionary!["SEARCH_MOVIES_APPKEY_IMDB"] as! String).fromBase64()!
    static let imdbBaseUrl:String = (Bundle.main.infoDictionary!["IMDB_BASE_URL"] as! String).fromBase64()!
    static let imdbBaseUrlImage:String = (Bundle.main.infoDictionary!["IMDB_BASE_URL_IMAGE"] as! String).fromBase64()!
    static let imdbLanguageDefault:String = "en-US"
    
    static let backgroundColorHexDefaultApp:String = "#f5cc5b"
    static let backgroundColorHexFilter:String = "#d9941e"
    
    static let jsonDateFormat:String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
}

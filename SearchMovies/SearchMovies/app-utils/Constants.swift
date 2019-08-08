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
    static let imdbLanguageDefault:String = "en-US"
}

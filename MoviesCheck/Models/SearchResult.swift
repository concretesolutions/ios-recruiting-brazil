//
//  SearchResult.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 26/10/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import Foundation

struct SearchResult:Codable {
    
    var items:Array<MediaItem>
    var totalResults:String
    var response:String
    
    enum CodingKeys : String, CodingKey {
        case items = "Search"
        case totalResults
        case response = "Response"
    }
    
    func getResponse()->Bool{
        if(response == "True"){
            return true
        }else{
            return false
        }
    }
    
}

//
//  Genre.swift
//  MovieFetcher
//
//  Created by Pedro Azevedo on 26/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import Foundation


class Genre:Codable{
    let id:Int!
    let name:String!
    
    
    init(id:Int,name:String){
        self.id = id
        self.name = name
    }
    
}

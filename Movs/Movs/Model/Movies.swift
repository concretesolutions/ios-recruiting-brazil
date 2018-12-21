//
//  Movies.swift
//  Movs
//
//  Created by Pedro Clericuzi on 20/12/2018.
//  Copyright © 2018 Pedro Clericuzi. All rights reserved.
//

import Foundation

class Movies {
    
    let id : Int
    let name : String
    let imageUrl : String
    var description : String?
    var year : String?
    
    init(id:Int, name: String, imageUrl:String) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
    }
    
    init(id:Int, name: String, imageUrl:String, description:String, year:String) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.description = description
        self.year = year
    }
}

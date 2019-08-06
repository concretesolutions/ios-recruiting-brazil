//
//  Genre.swift
//  Lyriks
//
//  Created by Eduardo Pereira on 03/08/19.
//  Copyright © 2019 Eduardo Pereira. All rights reserved.
//

import Foundation

struct GenreRequest:Decodable{
    let genres:[Genre]
}
struct Genre:Codable {
    //parameters needed
    let id:Int
    let name:String
}

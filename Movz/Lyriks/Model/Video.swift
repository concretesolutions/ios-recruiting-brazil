//
//  Video.swift
//  Lyriks
//
//  Created by Eduardo Pereira on 30/07/19.
//  Copyright © 2019 Eduardo Pereira. All rights reserved.
//

import Foundation

struct Video:Codable {
    //parameters needed
    let key:String?
}
struct VideoRequest:Decodable{
    let results:[Video]
}

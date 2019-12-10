//
//  CustomError.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 10/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//


import Foundation
import ObjectMapper

class CustomError: Mappable {
    
    var status_message: String?
    var status_code: Int?
    
    required init?(map: Map) {}

    func mapping(map: Map) {
        self.status_code <- map["status_code"]
        self.status_message <- map["status_message"]
    }
    
}

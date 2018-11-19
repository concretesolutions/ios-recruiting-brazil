//
//  ResponseConfiguration.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 16/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//

import UIKit

struct ResponseConfiguration: Decodable {
    
    struct ImagesConfiguration:Decodable {
        let baseUrl:String?
        let secureBaseUrl:String?
        let backdropSizes:[String]?
        let logoSizes:[String]?
        let posterpSizes:[String]?
        let profileSizes:[String]?
        let stillSizes:[String]?
    }
    
    let images: ImagesConfiguration?
    let changeKeys: [String]?
    
    init (images:ImagesConfiguration? = nil, changeKeys:[String]? = nil) {
        self.images = images
        self.changeKeys = changeKeys
    }
}

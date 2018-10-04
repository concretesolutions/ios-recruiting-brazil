//
//  Configuration.swift
//  Movs
//
//  Created by Dielson Sales on 03/10/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit

class ImagesConfiguration: Decodable {
    let baseURL: String
    let secureBaseURL: String

    enum CodingKeys: String, CodingKey {
        case baseURL = "base_url"
        case secureBaseURL = "secure_base_url"
    }
}

class Configuration: Decodable {

    let imagesConfiguration: ImagesConfiguration

    enum CodingKeys: String, CodingKey {
        case imagesConfiguration = "images"
    }
}

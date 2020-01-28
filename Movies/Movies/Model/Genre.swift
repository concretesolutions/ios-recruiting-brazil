//
//  Gere.swift
//  Muv Concrete
//
//  Created by Mariaelena Silveira on 25/01/20.
//  Copyright © 2020 Mariaelena Silveira. All rights reserved.
//

import Foundation

class Genre: Codable {
    var id: Int32
    var name: String

    enum CodingKeys: String, CodingKey {
        case id, name
    }
}

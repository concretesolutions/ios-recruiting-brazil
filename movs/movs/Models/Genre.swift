//
//  Genre.swift
//  movs
//
//  Created by Bruno Muniz Azevedo Filho on 28/12/18.
//  Copyright © 2018 bmaf. All rights reserved.
//

struct Genre: Codable {
    let name: String
    let identifier: Int

    enum CodingKeys: String, CodingKey {
		case name
        case identifier = "id"
    }
}

//
//  Popular.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 11/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import Foundation

struct Popular: Codable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [Movie]?
    private enum CodingKeys: String, CodingKey {
        case page
        case total_results
        case total_pages
        case results
    }
}

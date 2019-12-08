//
//  Movie.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 07/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation

class Movie: Codable {
    
    let id: Int
    let title: String?
    
}

extension Movie {
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
    }
}

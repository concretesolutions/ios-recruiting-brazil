//
//  Movie.swift
//  DesafioConcrete
//
//  Created by Ian Manor on 17/12/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import Foundation

public class Movie {
    let id: Int?
    let title: String
    let posterURL: URL?
    let description: String?
    
    init(title: String) {
        self.id = nil
        self.title = title
        self.posterURL = nil
        self.description = nil
    }
    
    init(id: Int, title: String, posterURL: URL, description: String) {
        self.id = id
        self.title = title
        self.posterURL = posterURL
        self.description = description
    }
}

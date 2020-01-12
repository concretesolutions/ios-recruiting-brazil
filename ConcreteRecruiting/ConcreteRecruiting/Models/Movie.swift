//
//  Movie.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 22/12/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import UIKit

struct Movie: Decodable {
    
    let id: Int
    let title: String
    let description: String
    let releaseDate: Date?
    let bannerPath: String
    let genres: [Int]
    
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description = "overview"
        case releaseDate = "release_date"
        case banner = "poster_path"
        case genres = "genre_ids"
    }
    
    init(id: Int) {
        
        self.id = id
        
        self.title = ""
        self.description = ""
        self.bannerPath = ""
        self.releaseDate = Date()
        self.genres = [Int]()
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decode(Int.self, forKey: .id)
        self.title = try values.decode(String.self, forKey: .title)
        self.description = try values.decode(String.self, forKey: .description)
       
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate, .withDashSeparatorInDate]
        let dateText = try values.decode(String.self, forKey: .releaseDate)
        self.releaseDate = formatter.date(from: dateText)
        
        self.bannerPath = try values.decode(String.self, forKey: .banner)
        self.genres = try values.decode([Int].self, forKey: .genres)
        
    }
    
}

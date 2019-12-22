//
//  Movie.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 22/12/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import UIKit

struct Movie: Decodable {
    
    // TODO: Remove the following line
    private let imgBase = "https://image.tmdb.org/t/p/w185/"
    
    let title: String
    let description: String
    let releaseDate: Date
    let banner: URL?
    
    let genres: [Genre]
    
    enum CodingKeys: String, CodingKey {
        case title
        case description = "overview"
        case releaseDate = "release_date"
        case banner = "poster"
        case genres
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try values.decode(String.self, forKey: .title)
        description = try values.decode(String.self, forKey: .description)
        releaseDate = try values.decode(Date.self, forKey: .releaseDate)
        
        let imgPath = try values.decode(String.self, forKey: .banner)
        banner = URL(string: imgBase+imgPath)
        
        genres = try values.decode([Genre].self, forKey: .genres)
        
//        let additionalInfo = try values.nestedContainer(keyedBy: AdditionalInfoKeys.self, forKey: .additionalInfo)
//        elevation = try additionalInfo.decode(Double.self, forKey: .elevation)
    }
    
}

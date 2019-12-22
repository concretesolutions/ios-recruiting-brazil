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
    
    var title: String
    var description: String
    var releaseDate: Date
    var banner: URL?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description = "overview"
        case releaseDate = "release_date"
        case banner = "poster"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try values.decode(String.self, forKey: .title)
        description = try values.decode(String.self, forKey: .description)
        releaseDate = try values.decode(Date.self, forKey: .releaseDate)
        let imgPath = try values.decode(String.self, forKey: .banner)
        
        banner = URL(string: imgBase+imgPath)
        
        
//        let additionalInfo = try values.nestedContainer(keyedBy: AdditionalInfoKeys.self, forKey: .additionalInfo)
//        elevation = try additionalInfo.decode(Double.self, forKey: .elevation)
    }
    
}

//
//  Movie.swift
//  ConcreteTMDb
//
//  Created by Pedro Del Rio Ortiz on 15/11/18.
//  Copyright © 2018 Pedro Ortiz. All rights reserved.
//

import Foundation
import UIKit

class Movie: Codable {
    
    // MARK: - Properties
    let title: String
    let overview: String
    let date: String
    let imgUrl: String
    var image: UIImage?
    
    // MARK: - Decodable keys
    
    enum MovieCodingKeys: String, CodingKey {
        case title
        case overview
        case date = "release_date"
        case path = "poster_path"
    }
    
    // MARK: - Inits
    
    init(title: String, overview: String, date: String, imgUrl: String) {
        self.title = title
        self.overview = overview
        self.date = date
        self.imgUrl = imgUrl
    }
    
    init(title: String, overview: String, date: String, imgUrl: String, picture: UIImage) {
        self.title = title
        self.overview = overview
        self.date = date
        self.imgUrl = imgUrl
        self.image = picture
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: MovieCodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(overview, forKey: .overview)
        try container.encode(date, forKey: .date)
    }
    
    required convenience init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: MovieCodingKeys.self)
        
        let title = try container.decode(String.self, forKey: .title)
        let overview = try container.decode(String.self, forKey: .overview)
        let date = try container.decode(String.self, forKey: .date)
        
        let path = (try? container.decode(String.self, forKey: .path)) ?? ""
        let imgUrl = "https://image.tmdb.org/t/p/w500\(path)"
        
        self.init(title: title, overview: overview, date: date, imgUrl: imgUrl)
    }
    
  
}

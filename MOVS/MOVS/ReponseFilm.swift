//
//  ReponseFilm.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 18/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class ResponseFilm: Decodable {
    //MARK:- Descodable Keys
    enum CodingKeysFilm: String, CodingKey {
        case id
        case overview
        case poster_path
        case release_date
        case title
        case genres_ids = "genre_ids"
    }
    
    //MARK: - Variables
    var id: Int?
    var overview: String?
    var poster_path: String?
    var release_date: String?
    var title: String?
    var genres: [Int]?
    
    //MARK: - Init
    public init(){
    }
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeysFilm.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
        self.poster_path = try container.decodeIfPresent(String.self, forKey: .poster_path)
        self.release_date = try container.decodeIfPresent(String.self, forKey: .release_date)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.genres = try container.decodeIfPresent([Int].self, forKey: .genres_ids)
    }
    
}

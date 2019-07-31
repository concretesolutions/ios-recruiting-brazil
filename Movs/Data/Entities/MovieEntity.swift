//
//  MovieEntity.swift
//  DesafioConcrete_BrunoChagas
//
//  Created by Bruno Chagas on 23/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation

class MovieEntity: NSObject, NSCoding, Entity {
    
    //MARK: - Properties
    public var id: Int?
    public var title: String?
    public var releaseDate: String?
    public var genresIds: [Int]?
    public var poster: String?
    public var movieDescription: String?
    
    //MARK: - Enumeration
    enum MovieEntityKeys: String, CodingKey {
        case id = "id"
        case title = "original_title"
        case releaseDate = "release_date"
        case genresIds = "genre_ids"
        case poster = "poster_path"
        case movieDescription = "overview"
    }
    
    //MARK: - Initialization
    override init() {}
    
    required init?(coder aDecoder: NSCoder) {
        do {
            id = aDecoder.decodeObject(forKey: MovieEntityKeys.id.rawValue) as? Int
            title = aDecoder.decodeObject(forKey: MovieEntityKeys.title.rawValue) as? String
            releaseDate = aDecoder.decodeObject(forKey: MovieEntityKeys.releaseDate.rawValue) as? String
            genresIds = aDecoder.decodeObject(forKey: MovieEntityKeys.genresIds.rawValue) as? [Int]
            poster = aDecoder.decodeObject(forKey: MovieEntityKeys.poster.rawValue) as? String
            movieDescription = aDecoder.decodeObject(forKey: MovieEntityKeys.movieDescription.rawValue) as? String
        }
    }
    
    required init(from decoder: Decoder) {
        do {
            let container = try! decoder.container(keyedBy: MovieEntityKeys.self)
            id = try? container.decode(Int.self, forKey: .id)
            title = try? container.decode(String.self, forKey: .title)
            releaseDate = try? container.decode(String.self, forKey: .releaseDate)
            genresIds = try? container.decode([Int].self, forKey: .genresIds)
            poster = try? container.decode(String.self, forKey: .poster)
            movieDescription = try? container.decode(String.self, forKey: .movieDescription)
        }
    }
    
    required init(to encoder: Encoder) throws {
        do {
            var container = encoder.container(keyedBy: MovieEntityKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(title, forKey: .title)
            try container.encode(releaseDate, forKey: .releaseDate)
            try container.encode(genresIds, forKey: .genresIds)
            try container.encode(poster, forKey: .poster)
            try container.encode(movieDescription, forKey: .movieDescription)
        }
    }
    
    //MARK: - Functions
    func encode(with aCoder: NSCoder){
        aCoder.encode(self.id, forKey: MovieEntityKeys.id.rawValue)
        aCoder.encode(self.title, forKey: MovieEntityKeys.title.rawValue)
        aCoder.encode(self.releaseDate, forKey: MovieEntityKeys.releaseDate.rawValue)
        aCoder.encode(self.genresIds, forKey: MovieEntityKeys.genresIds.rawValue)
        aCoder.encode(self.poster, forKey: MovieEntityKeys.poster.rawValue)
        aCoder.encode(self.movieDescription, forKey: MovieEntityKeys.movieDescription.rawValue)
    }
    
    /**
     Make a string from release date containing only the year.
     
     - Returns: A string containing movies release year.
     */
    func formatDateString() -> String {
        var newString: String = ""
        if let releaseDate = releaseDate {
            newString = String(releaseDate.prefix(4))
            return newString
        }
        return "Unknown"
    }

    /**
     Transfoms an instance from this object into a dictionary.
     
     - Returns: A dictionary.
     */
    func toDict() -> [String:Any] {
        var dict = [String:Any]()
        let otherSelf = Mirror(reflecting: self)
        for child in otherSelf.children {
            if let key = child.label {
                dict[key] = child.value
            }
        }
        return dict
    }
}

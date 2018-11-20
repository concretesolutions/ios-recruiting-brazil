//
//  File.swift
//  Movs
//
//  Created by Erick Lozano Borges on 11/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import RealmSwift

struct Movie {
    
    var id: Int
    var title: String
    var genres: [Genre]
    var overview: String
    var releaseYear: String
    var thumbFilePath: String?
    var isFavourite: Bool = false
    var thumbnail: UIImage?
    
    public init(id: Int, title: String, genres: [Genre], overview: String, releaseYear: String, thumbFilePath: String) {
        self.id = id
        self.title = title
        self.genres = genres
        self.overview = overview
        self.releaseYear = releaseYear
        self.thumbFilePath = thumbFilePath
    }
    
    public init(_ movieRlm: MovieRlm) {
        id = movieRlm.id
        title = movieRlm.title
        genres = movieRlm.genres.map({ return Genre($0) })
        overview = movieRlm.overview
        releaseYear = movieRlm.releaseYear
        thumbFilePath = ""
        isFavourite = movieRlm.isFavourite
        thumbnail = UIImage(named: "placeholder_poster")!
        if let aThumbData = movieRlm.thumbnailData {
            thumbnail = UIImage(data: aThumbData)
        }
    }
    
    func genresText() -> String {
        var genresText = ""
        self.genres.forEach({genresText.append("\($0.name ?? ""), ")})
        if !(genresText.isEmpty){
            genresText.removeLast(2)
        } else {
            return "No information"
        }
        return genresText
    }
    
    mutating func favourite() {
        self.isFavourite = true
    }
    
    func rlm() -> MovieRlm {
        return MovieRlm.build { (objectRlm) in
            objectRlm.id = self.id
            objectRlm.title = self.title
            genres.forEach({ objectRlm.genres.append($0.rlm()) })
            objectRlm.overview = self.overview
            objectRlm.releaseYear = self.releaseYear
            objectRlm.thumbnailData = (self.thumbnail ?? UIImage(named: "placeholder_poster")!).jpegData(compressionQuality: 1.0)
        }        
    }
    
}

extension Movie: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case genres = "genre_ids"
        case overview
        case thumbFilePath = "poster_path"
        case releaseYear = "release_date"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decode(String.self, forKey: .overview)
        thumbFilePath = try? container.decode(String.self, forKey: .thumbFilePath)
        
        let releaseDate = try container.decode(String.self, forKey: .releaseYear)
        let index = releaseDate.index(releaseDate.startIndex, offsetBy: 4)
        releaseYear = String(releaseDate[..<index])
        
        genres = [Genre]()
        let ids = try container.decode([Int].self, forKey: .genres)
        ids.forEach({ self.genres.append(Genre(id:$0)) })
    }
    
}

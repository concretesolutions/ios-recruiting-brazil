//
//  Genre.swift
//  Movie
//
//  Created by Elton Santana on 09/07/19.
//  Copyright © 2019 Memo. All rights reserved.
//

import Foundation

// MARK: - Genres
class Genres: Codable {
    let genres: [Genre]?
    
    init(genres: [Genre]?) {
        self.genres = genres
    }
}

// MARK: Genres convenience initializers and mutators

extension Genres {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Genres.self, from: data)
        self.init(genres: me.genres)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        genres: [Genre]?? = nil
        ) -> Genres {
        return Genres(
            genres: genres ?? self.genres
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Genre
class Genre: Codable {
    let id: Int?
    let name: String?
    
    init(id: Int?, name: String?) {
        self.id = id
        self.name = name
    }
}

// MARK: Genre convenience initializers and mutators

extension Genre {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Genre.self, from: data)
        self.init(id: me.id, name: me.name)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        id: Int?? = nil,
        name: String?? = nil
        ) -> Genre {
        return Genre(
            id: id ?? self.id,
            name: name ?? self.name
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

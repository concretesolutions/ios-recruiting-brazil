//
//  Page.swift
//  Movie
//
//  Created by Elton Santana on 09/07/19.
//  Copyright © 2019 Memo. All rights reserved.
//

import Foundation

// MARK: - Page
class Page: Codable {
    let page, totalResults, totalPages: Int?
    let results: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
    
    init(page: Int?, totalResults: Int?, totalPages: Int?, results: [Movie]?) {
        self.page = page
        self.totalResults = totalResults
        self.totalPages = totalPages
        self.results = results
    }
}

// MARK: Page convenience initializers and mutators

extension Page {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Page.self, from: data)
        self.init(page: me.page, totalResults: me.totalResults, totalPages: me.totalPages, results: me.results)
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
        page: Int?? = nil,
        totalResults: Int?? = nil,
        totalPages: Int?? = nil,
        results: [Movie]?? = nil
        ) -> Page {
        return Page(
            page: page ?? self.page,
            totalResults: totalResults ?? self.totalResults,
            totalPages: totalPages ?? self.totalPages,
            results: results ?? self.results
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

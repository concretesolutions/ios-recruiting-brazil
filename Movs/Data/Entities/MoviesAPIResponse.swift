//
//  MoviesAPIResponse.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 27/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation

class MoviesAPIResponse: Entity, Codable {
    //MARK: - Properties
    public let page: Int
    public let totalResults: Int
    public let totalPages: Int
    public let results: [MovieEntity]
    
    //MARK: - Enumeration
    enum MovieAPIResponseKeys: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
    }
    
    //MARK: - Initialization
    required init(from decoder: Decoder) {
        let container = try! decoder.container(keyedBy: MovieAPIResponseKeys.self)
        page = try! container.decode(Int.self, forKey: .page)
        totalResults = try! container.decode(Int.self, forKey: .totalResults)
        totalPages = try! container.decode(Int.self, forKey: .totalPages)
        results = try! container.decode([MovieEntity].self, forKey: .results)
    }
}

//
//  DiscoverMovieListModel.swift
//  DataMovie
//
//  Created by Andre on 26/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

struct DiscoverMovieListModel: Decodable {
    
    var page: Int
    var totalPages: Int
    var totalResults: Int
    var results: [DiscoverMovieItemModel]
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case results = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try container.decodeIfPresent(Int.self, forKey: .page) ?? 1
        totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages) ?? 1
        totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults) ?? 0
        results = try container.decodeIfPresent([DiscoverMovieItemModel].self, forKey: .results) ?? []
    }
    
    
}

extension DiscoverMovieListModel {
    
    init() {
        page = 0
        totalPages = 1
        totalResults = 0
        results = []
    }
    
}

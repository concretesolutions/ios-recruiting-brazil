//
//  PopularMovie.swift
//  Movs
//
//  Created by Adann Simões on 16/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import Foundation
import UIKit.UIImage


struct PopularMovie {
    let page: Int?
    let totalResults: Int?
    let totalPages: Int?
    var results: [Result]?
}

extension PopularMovie: Codable {
	enum CodingKeys: String, CodingKey {
		case page = "page"
		case totalResults = "total_results"
		case totalPages = "total_pages"
		case results = "results"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		page = try values.decodeIfPresent(Int.self, forKey: .page)
		totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
		totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
		results = try values.decodeIfPresent([Result].self, forKey: .results)
	}

}

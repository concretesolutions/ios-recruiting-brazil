//
//  PopularMovieResponse.swift
//  MyMovie
//
//  Created by Paulo Gutemberg on 25/10/2018.
//  Copyright © 2018 Paulo Gutemberg. All rights reserved.
//

import UIKit

struct PopularMovieResponse: Codable {
	var page: Int?
	var total_results: Int?
	var total_pages: Int?
	var results: [Movie]?
}

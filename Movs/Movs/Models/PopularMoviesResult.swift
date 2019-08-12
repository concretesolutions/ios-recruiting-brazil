//
//  PopularMoviesResult.swift
//  Movs
//
//  Created by Tiago Chaves on 12/08/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import Foundation

struct PopularMoviesResult: Codable, CustomStringConvertible {
	
	let page	    : Int?
	let total_pages : Int?
	let results		: [Movie]?
	
	var description: String {
		return "Page \(page ?? 0) of \(total_pages ?? 0) pages."
	}
}

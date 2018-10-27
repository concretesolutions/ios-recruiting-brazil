//
//  FilterSource.swift
//  PhilmaXXX
//
//  Created by Guilherme Guimaraes on 24/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import Domain

struct Filter {
	var genres: [Genre]
	var yearOfReleases: [Int]
	
	init(genres: [Genre], yearOfReleases: [Int]) {
		self.genres = genres
		self.yearOfReleases = yearOfReleases
	}
}

extension Filter {
	func genreIDs() -> [Int]{
		return genres.map({ $0.id })
	}
}

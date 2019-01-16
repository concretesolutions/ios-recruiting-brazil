//
//  TMDB_Image.swift
//  PhilmaXXX
//
//  Created by Guilherme Guimaraes on 22/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import Domain

fileprivate struct TMDB_Image {
	static let imageBaseURL = URL(string: "https://image.tmdb.org/t/p/w500")!
}

extension Movie {
	func posterImageURL() -> URL {
		return TMDB_Image.imageBaseURL.appendingPathComponent(posterPath ?? "/")
	}
	
	func backdropImageURL() -> URL {
		return TMDB_Image.imageBaseURL.appendingPathComponent(backdropPath ?? "/")
	}
}

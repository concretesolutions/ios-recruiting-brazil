//
//  TestMovie.swift
//  DomainTests
//
//  Created by Guilherme Guimaraes on 26/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import Domain

public struct TestMovie {
	public static var movie1: Movie {
		return Movie(id: 1, title: "Hello World", overview: "This is a beautiful test.", releaseDate: Date(), posterPath: "/rzRwTcFvttcN1ZpX2xv4j3tSdJu.jpg", backdropPath: "/3P52oz9HPQWxcwHOwxtyrVV1LKi.jpg", genreIDs: [1, 3, 2])
	}
	
	public static var movie1alt: Movie {
		return Movie(id: 1, title: "This is another World", overview: "This is another beautiful test.", releaseDate: Date(), posterPath: "/rzRwTcFvttcN1ZpX2xv4j3tSdJu.jpg", backdropPath: "/3P52oz9HPQWxcwHOwxtyrVV1LKi.jpg", genreIDs: [1, 3, 2])
	}
	
	public static var movie2: Movie {
		return Movie(id: 2, title: "This is a Different World", overview: "This is yet another beautiful test.", releaseDate: Date(), posterPath: "/rzRwTcFvttcN1ZpX2xv4j3tSdJu.jpg", backdropPath: "/3P52oz9HPQWxcwHOwxtyrVV1LKi.jpg", genreIDs: [1, 3, 2])
	}
}

//
//  MovieSpec.swift
//  DomainTests
//
//  Created by Guilherme Guimaraes on 26/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Nimble
import Quick
import Placeholder

@testable import Domain

class MovieSpec: QuickSpec {
	
	override func spec() {
		describe("a movie") {
			context("when initialized with only its non-optional params", {
				let movie1 = TestMovie.movie1
				
				context("in comparison with other movies with same id and different params", {
					let movie1alt = TestMovie.movie1alt
					
					it("should be equal") {
						expect {
							return (movie1 == movie1alt)
							}.to(be(true))
					}
				})
				
				context("but when in comparison with other movies with different id", {
					let movie2 = TestMovie.movie2
					
					it("should be not equal") {
						expect {
							return movie1 == movie2
							}.toNot(be(true))
					}
				})
			})
			
			context("initialized from json decoder and using a json file", {
				let decoder = JSONDecoder()
				let dateFormatter = DateFormatter()
				dateFormatter.dateFormat = "yyyy-MM-dd"
				decoder.dateDecodingStrategy = .formatted(dateFormatter)
				
				it("should parse correctly using a valid json"){
					let fileURL = Bundle(for: MovieSpec.self).url(forResource: "validMovie", withExtension: "json")!
					let validData = try! Data(contentsOf: fileURL)
					expect {
						try decoder.decode(Movie.self, from: validData)
						}.notTo(throwError())
				}
				
				it("should parse correctly using an invalid json"){
					let fileURL = Bundle(for: MovieSpec.self).url(forResource: "invalidMovie", withExtension: "json")!
					let validData = try! Data(contentsOf: fileURL)
					expect {
						try decoder.decode(Movie.self, from: validData)
						}.to(throwError())
				}
				
			})
		}
	}
}

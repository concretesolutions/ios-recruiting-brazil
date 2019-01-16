//
//  GenreSpec.swift
//  DomainTests
//
//  Created by Guilherme Guimaraes on 26/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Quick
import Nimble
import Placeholder

@testable import Domain

class GenreSpec: QuickSpec {
	
	override func spec() {
		describe("a genre") {
			context("when initialized with only its non-optional params", {
				let genre1 = TestGenre.genre1
				
				context("in comparison with other genres with same id and different params", {
					let genre1alt = TestGenre.genre1alt
					
					it("should be equal") {
						expect(genre1 == genre1alt).to(be(true))
					}
				})
				
				context("but when in comparison with other genres with different id", {
					let genre2 = TestGenre.genre2
					
					it("should be not equal") {
						expect(genre1 == genre2).toNot(be(true))
					}
				})
			})
			
			context("initialized from json decoder", {
				let decoder = JSONDecoder()
				let dateFormatter = DateFormatter()
				dateFormatter.dateFormat = "yyyy-MM-dd"
				decoder.dateDecodingStrategy = .formatted(dateFormatter)
				
				context("and using a valid json file", closure: {
					let fileURL = Bundle(for: GenreSpec.self).url(forResource: "validGenre", withExtension: "json")!
					let validData = try! Data(contentsOf: fileURL)
					
					it("should parse correctly"){
						expect{
							try decoder.decode(Genre.self, from: validData)
							}.notTo(throwError())
					}
				})
				
				context("and using an invalid json file", closure: {
					let fileURL = Bundle(for: GenreSpec.self).url(forResource: "invalidGenre", withExtension: "json")!
					let validData = try! Data(contentsOf: fileURL)
					it("shouldn't parse"){
						expect{
							try decoder.decode(Genre.self, from: validData)
							}.to(throwError())
					}
				})
				
			})
		}
	}
}

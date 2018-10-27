//
//  RealmMovie.swift
//  RealmPlatformTests
//
//  Created by Guilherme Guimaraes on 26/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Quick
import Nimble
import Domain
import RealmSwift

@testable import RealmPlatform

class RealmMovieSpec: QuickSpec {
	override func spec() {
		
		describe("a movie in realm") {
			let realmM = RealmMovie()
			
			realmM.id = 1
			realmM.title = "This is a Test!"
			realmM.overview = "What a wonderful world."
			realmM.posterPath = "/thisIsATest.jpg"
			realmM.backdropPath = "/thisIsAnotherTest.jpg"
			realmM.releaseDate = Date()
			
			context("and its base data and return", {
				let baseM = realmM.baseData()
				let returnM = baseM.realmData()
				
				it("should have identical properties"){
					expect( realmM.id == baseM.id && realmM.title == baseM.title && realmM.overview == baseM.overview && realmM.releaseDate == baseM.releaseDate && realmM.posterPath == baseM.posterPath && realmM.backdropPath == baseM.backdropPath && Array(realmM.genreIDs.map({ $0 })) == baseM.genreIDs ).to(be(true))
				}
				
				it("also should be identical to its base replic method return"){
					expect( realmM.id == returnM.id && realmM.title == returnM.title && realmM.overview == returnM.overview && realmM.releaseDate == returnM.releaseDate && realmM.posterPath == returnM.posterPath && realmM.backdropPath == returnM.backdropPath ).to(be(true))
				}
			})
		}
	}
}

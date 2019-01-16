//
//  RealmGenre.swift
//  RealmPlatformTests
//
//  Created by Guilherme Guimaraes on 26/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Quick
import Nimble
import Domain

@testable import RealmPlatform

class RealmGenreSpec: QuickSpec {
	override func spec() {
		
		describe("a genre in realm") {
			let realmG = RealmGenre()
			
			realmG.id = 1
			realmG.name = "Hello!"
			
			context("and its base data and return", {
				let baseG = realmG.baseData()
				let returnG = baseG.realmData()
				
				it("should have identical properties"){
					expect( realmG.id == baseG.id && realmG.name == baseG.name ).to(be(true))
				}
				
				it("also should be identical to its base replic method return"){
					expect( realmG.id == returnG.id && realmG.name == returnG.name).to(be(true))
				}
			})
		}
	}
}

//
//  FavoritesRepository.swift
//  RealmPlatformTests
//
//  Created by Guilherme Guimaraes on 26/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Nimble
import Quick
import RealmSwift
import Domain
import Placeholder

@testable import RealmPlatform

class FavoritesRepositorySpec: QuickSpec {
	override func spec(){
		var configuration = Realm.Configuration.defaultConfiguration
		configuration.inMemoryIdentifier =  "com.PhilmaXXX.Debug.RealmPlatform.FavoritesRepository"
		let realm = try! Realm(configuration: configuration)
		
		describe("the clear favorite's repository") {
			let repository = FavoritesRepository(realm: realm)
			beforeSuite {
				repository.deleteAll()
			}
			
			it("should have nothing on them"){
				expect(repository.get()).to(be([] as [Movie]))
			}
			
			context("inserting a new data", {
				let movie = TestMovie.movie1
				repository.upsert(object: movie)
				
				context("retrieves the movies from repository ", {
					let retrievedMovies = repository.get()
					
					it("should have one data on the repository"){
						expect(retrievedMovies.count).to(be(1))
					}
					
					it("one data retrieved should be equal to the first created"){
						expect(movie == retrievedMovies.first!).to(be(true))
					}
					
					context("and after deleting the only one item in repository, equal to the one created", closure: {
						repository.delete(object: movie)
						
						it("should have no items on the repository"){
							expect(repository.get().count).to(be(0))
						}
					})
				})
			})
		}
	}
}

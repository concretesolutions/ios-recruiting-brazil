//
//  GenresRepository.swift
//  RealmPlatformTests
//
//  Created by Guilherme Guimaraes on 26/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Domain
import Nimble
import Quick
import RealmSwift
import Placeholder

@testable import RealmPlatform

class GenresRepositorySpec: QuickSpec {
	override func spec(){
		var configuration = Realm.Configuration.defaultConfiguration
		configuration.inMemoryIdentifier =  "com.PhilmaXXX.Debug.RealmPlatform.GenresRepository"
		let realm = try! Realm(configuration: configuration)
		
		describe("the clear genres repository") {
			let repository = GenresRepository(realm: realm)
			beforeEach {
				repository.deleteAll()
			}
			
			it("should have nothing on them"){
				expect {
					return repository.get()
					}.to(be([] as [Genre]))
			}
			
			context("inserting a new data", {
				let genre = TestGenre.genre1
				repository.upsert(object: genre)
				
				context("retrieves the genres from repository ", {
					let retrievedMovies = repository.get()
					
					it("should have one data on the repository"){
						expect {
							return retrievedMovies.count
							}.to(be(1))
						
					}
					
					it("one data retrieved should be equal to the first created"){
						expect{
							return genre == retrievedMovies.first!
							}.to(be(true))
					}
					
					context("and after deleting the only one item in repository, equal to the one created", closure: {
						repository.delete(object: genre)
						
						it("should have no items on the repository"){
							expect(repository.get().count).to(be(0))
						}
					})
				})
			})
			
			context("after populating the repository with items that has id from 1 to 5, and set them on the repository", closure: {
				var genreArray = [Genre]()
				for index in 1...5 {
					var item = TestGenre.genre1
					item.id = index
					genreArray.append(item)
				}
				beforeEach {
					repository.set(objects: genreArray)
				}
				
				it("should have 5 items", closure: {
					expect(repository.get().count).to(be(5))
				})
				
				it("also should get only three items if we fetch for ids [1, 3, 5]", closure: {
					expect(repository.get(with: [1, 3, 5]).count).to(be(3))
				})
			})
		}
		
	}
}

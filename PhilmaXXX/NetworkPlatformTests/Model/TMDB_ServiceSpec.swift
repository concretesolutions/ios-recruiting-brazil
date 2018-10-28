//
//  TMDB_Service.swift
//  NetworkPlatformTests
//
//  Created by Guilherme Guimaraes on 27/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import XCTest
import Nimble
import Quick
import Moya
import Domain
import Alamofire

@testable import NetworkPlatform

class TMDB_ServiceSpec: QuickSpec {

	override func spec(){
		var service = MoyaProvider<TMDB_Service>()
		let decoder = JSONDecoder.standardDecoder
		beforeSuite {
			service = .init(manager: Alamofire.SessionManager.standardManager)
		}
		
		context("the webservice") {
			describe("should get the popular movies, page to page", closure: {
				var movies = Set<Movie>()
				
				beforeSuite {
					for index in 1...3 {
						service.request(TMDB_Service.getPopularMovies(pageNumber: index), completion: { (result) in
							switch result {
							case .success(let value):
								let fetchedMovies = try! value.map([Movie].self, atKeyPath: "results", using: decoder, failsOnEmptyData: false)
								fetchedMovies.forEach({ (movie) in
									movies.insert(movie)
								})
							case .failure(let error):
								print(error.localizedDescription)
							}
						})
					}
				}
				
				it("eventually having 80% of unique movies", closure: {
					expect(movies.count).toEventually(beGreaterThan(25))
				})
			})
			
			describe("should get all movie genres", closure: {
				var genres = Set<Genre>()
				
				beforeSuite {
					service.request(TMDB_Service.getGenres, completion: { (result) in
						switch result {
						case .success(let value):
							let fetchedGenres = try! value.map([Genre].self, atKeyPath: "genres", using: decoder, failsOnEmptyData: false)
							fetchedGenres.forEach({ (genre) in
								genres.insert(genre)
							})
						case .failure(let error):
							print(error.localizedDescription)
						}
					})
				}
				
				it("eventually having something", closure: {
					expect(genres.count).toEventually(beGreaterThan(0))
				})
			})
		}
	}
	
}

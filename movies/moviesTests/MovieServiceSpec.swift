//
//  MovieServiceSpec.swift
//  moviesTests
//
//  Created by Jacqueline Alves on 03/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Quick
import Nimble

@testable import movies

class MovieServiceSpec: QuickSpec {
    override func spec() {
        describe("the 'Movie Service' ") {
            context("when requested to fetch popular movies ") {
                it("should have some response") {
                    waitUntil(timeout: 5) { done in
                        MovieService.fecthMovies { result in
                            switch result {
                            case .failure(let error):
                                fail(error.localizedDescription)
                            case .success(let response):
                                expect(response.results).notTo(beEmpty())
                            }
                            
                            done()
                        }
                    }
                }
            }
            
            context("when requested to fetch genres") {
                it("should have some response") {
                    waitUntil(timeout: 2) { done in
                        MovieService.fetchGenres()
                        expect(MovieService.genres).notTo(beEmpty())
                        
                        done()
                    }
                }
            }
        }
    }
}

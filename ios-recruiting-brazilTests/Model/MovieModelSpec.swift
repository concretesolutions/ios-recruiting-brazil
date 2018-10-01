//
//  MovieModelSpec.swift
//  ios-recruiting-brazilTests
//
//  Created by André Vieira on 01/10/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import Mapper
import Quick
import Nimble

@testable import ios_recruiting_brazil

class MovieModelSpec: QuickSpec {
    
    var movie: MovieModel?
    var RLMMovieModel: RLMMovieModel?
    var error: Error?
    
    override func spec() {
        
        describe("MovieModelSpec - parse") {
            beforeEach {
                if let path = Bundle.main.path(forResource: "MovieMock", ofType: "json") {
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                        let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                        if let jsonResult = jsonResult as? NSDictionary{
                            self.movie = try MovieModel(map: Mapper(JSON: jsonResult))
                        }
                    } catch {
                        self.error = error
                    }
                }
            }
            
            it("id", closure: {
                expect(self.movie?.id).to(equal(272))
            })
            
            it("posterPath", closure: {
                expect(self.movie?.posterPath).to(equal("/dr6x4GyyegBWtinPBzipY02J2lV.jpg"))
            })
            
            it("title", closure: {
                expect(self.movie?.title).to(equal("Batman Begins"))
            })
            
            it("desc", closure: {
                expect(self.movie?.desc).to(equal("Batman Begins"))
            })
            
            it("releaseDate", closure: {
                expect(self.movie?.releaseDate).to(equal("2005-06-10"))
            })
            
            it("releaseYear", closure: {
                expect(self.movie?.releaseYear).to(equal("2005"))
            })
            
            it("genders", closure: {
                expect(self.movie?.genders.count).to(equal(3))
            })
            
            it("isFavorite", closure: {
                expect(self.movie?.isFavorite).to(equal(false))
            })
        }
        
        describe("MovieModelSpec - asRealm") {
            beforeEach {
                if let path = Bundle.main.path(forResource: "MovieMock", ofType: "json") {
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                        let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                        if let jsonResult = jsonResult as? NSDictionary{
                            self.movie = try MovieModel(map: Mapper(JSON: jsonResult))
                            self.RLMMovieModel = self.movie?.asRealm()
                        }
                    } catch {
                        self.error = error
                    }
                }
            }
            
            it("id", closure: {
                expect(self.RLMMovieModel?.id).to(equal(272))
            })
            
            it("posterPath", closure: {
                expect(self.RLMMovieModel?.posterPath).to(equal("/dr6x4GyyegBWtinPBzipY02J2lV.jpg"))
            })
            
            it("title", closure: {
                expect(self.RLMMovieModel?.title).to(equal("Batman Begins"))
            })
            
            it("desc", closure: {
                expect(self.RLMMovieModel?.desc).to(equal("Batman Begins"))
            })
            
            it("releaseDate", closure: {
                expect(self.RLMMovieModel?.releaseDate).to(equal("2005-06-10"))
            })
            
            it("releaseYear", closure: {
                expect(self.RLMMovieModel?.releaseYear).to(equal("2005"))
            })
            
            it("genders", closure: {
                expect(self.RLMMovieModel?.genders.count).to(equal(3))
            })
            
            it("isFavorite", closure: {
                expect(self.RLMMovieModel?.isFavorite).to(equal(false))
            })
        }
    }
}

//
//  RouterSpec.swift
//  ConcreteChallengeTests
//
//  Created by Kaique Damato on 20/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import ConcreteChallenge

class RouterSpec: QuickSpec {
    override func spec() {
        
        describe("set up router for movies") {
            
            let router = Router.getMovies
            
            it("and check scheme") {
                expect(router.scheme) == "https"
            }
            
            it("and check host") {
                expect(router.host) == "api.themoviedb.org"
            }
            
            it("and check method") {
                expect(router.method) == "GET"
            }
            
            it("and check parameters") {
                let apiKey = "4b005d0e4deec9b57eb0678a441110ce"
                let currentPage = UserDefaults.standard.integer(forKey: UserDefaultsConstants.currentPage)
                
                expect(router.parameters) == [URLQueryItem(name: "api_key", value: apiKey),
                                              URLQueryItem(name: "language", value: "en-US"),
                                              URLQueryItem(name: "page", value: "\(currentPage)")]
            }
            
            it("and check path") {
                expect(router.path) == "/3/movie/popular"
            }
            
            describe("set up router for genres") {
                
                let router = Router.getGenres
                
                it("and check scheme") {
                    expect(router.scheme) == "https"
                }
                
                it("and check host") {
                    expect(router.host) == "api.themoviedb.org"
                }
                
                it("and check method") {
                    expect(router.method) == "GET"
                }
                
                it("and check parameters") {
                    let apiKey = "4b005d0e4deec9b57eb0678a441110ce"
                    
                    expect(router.parameters) == [URLQueryItem(name: "api_key", value: apiKey),
                                                  URLQueryItem(name: "language", value: "en-US")]
                }
                
                it("and check path") {
                    expect(router.path) == "/3/genre/movie/list"
                }
            }
        }
    }
}

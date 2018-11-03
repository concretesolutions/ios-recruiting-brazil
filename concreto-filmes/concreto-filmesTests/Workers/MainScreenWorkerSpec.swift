//
//  MainScreenWorkerSpec.swift
//  concreto-filmesTests
//
//  Created by Leonel Menezes on 02/11/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import concreto_filmes

class MainScreenWorkerSpec: QuickSpec {
    override func spec() {
        let mainScreenWorker = MainScreenWorker()
        
        describe("Worker for popular movies") {
            
            it("Should get popular movies first page", closure: {
                waitUntil(timeout: 20, action: { (done) in
                    mainScreenWorker.fetchPopularMovies(request: MainScreen.FetchPopularMovies.Request(index: 1), completion: { (movies, errorMessage) in
                        expect(movies).toNot(beNil())
                        expect(errorMessage).to(beNil())
                        done()
                    })
                })
            })
            
            it("Should not present popular movies if page is not valid", closure: {
                waitUntil(timeout: 20, action: { (done) in
                    mainScreenWorker.fetchPopularMovies(request: MainScreen.FetchPopularMovies.Request(index: 0), completion: { (movies, errorMessage) in
                        expect(movies).to(beNil())
                        expect(errorMessage).toNot(beNil())
                        done()
                    })
                })
            })
        }
        
        describe("Search for movies") {
            it("should get movies by query name", closure: {
                waitUntil(timeout: 20, action: { (done) in
                    mainScreenWorker.fetchMoviesByQuery(request: MainScreen.FetchQueryMovies.Request(index: 1, text: "Harry Potter"), completion: { (movies, errorMessage) in
                        expect(movies).toNot(beNil())
                        expect(errorMessage).to(beNil())
                        done()
                    })
                })
            })
            
            it("should get an error if request is invalid", closure: {
                waitUntil(timeout: 20, action: { (done) in
                    mainScreenWorker.fetchMoviesByQuery(request: MainScreen.FetchQueryMovies.Request(index: 0, text: "Harry Potter"), completion: { (movies, errorMessage) in
                        expect(movies).to(beNil())
                        expect(errorMessage).toNot(beNil())
                        done()
                    })
                })
            })
        }
        
        describe("Fetch genres") {
            it("should get all genres from the api", closure: {
                waitUntil(timeout: 20, action: { (done) in
                    mainScreenWorker.fetchAllMovieGenres(completion: { (result) in
                        switch result {
                        case .success:
                            done()
                        case .failure(let message):
                            fail(message)
                        }
                    })
                })
            })
        }
    }
}

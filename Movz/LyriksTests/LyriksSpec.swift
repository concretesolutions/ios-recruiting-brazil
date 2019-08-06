//
//  LyriksTests.swift
//  LyriksTests
//
//  Created by Eduardo Pereira on 28/07/19.
//  Copyright © 2019 Eduardo Pereira. All rights reserved.
//
import Foundation
import Quick
import Nimble


@testable import Lyriks

class LyriksTests: QuickSpec {

    override func spec(){
        testAPICall()
        testViewModels()
        
    }
    func testViewModels(){
        describe("View Model") {
            let movieMock = MovieMock()
            let movie = movieMock.mock[0]
            context("on Collection cell"){
                let model = CollectionCellViewModel(movie: movie)
                it("Should have same title"){
                    expect(movie.title).to(equal(model.title.string))
                }
                it("Should have same id"){
                    expect(movie.id).to(equal(model.id))
                }
                it("Should have same image"){
                    expect(movie.image).to(equal(model.image))
                }
                it("Have the right model reference"){
                    expect(movie).to(be(model.getMovie()))
                }
            }
            context("on Table cell"){
                let model = TableCellViewModel(movie: movie)
                
                it("Should have same title"){
                    expect(movie.title).to(equal(model.title.string))
                }
                it("Have the same release"){
                    expect(movie.vote_average).to(be(model.vote.string))
                }
                
                it("Have the right model reference"){
                    expect(movie).to(be(model.getMovie()))
                }
            }
            
            context("on Detail View Model"){
                let model = DetailsViewModel(movie: movie)
                
                it("Should have same id"){
                    expect(movie.id).to(equal(model.id))
                }
                it("Should have same overview"){
                    expect(model.overview.string).to(contain(movie.overview))
                }
                it("Should have same rate"){
                    expect(model.voteAverage.string).to(contain(movie.vote_average))
                }
                
                
            }
            
        }
    }
    func testAPICall(){
        describe("MovieAPI") {
            context("Requests"){
                it("can discover") {
                    
                    waitUntil(timeout: 2) { done in
                        MovieAPI.movieRequest(mode: Request.discover([]), onComplete: { result,err in
                            expect(err).to(beNil())
                            done()
                        })
                        
                    }
                }
                it("can get popular") {
                  
                    waitUntil(timeout: 2) { done in
                        MovieAPI.movieRequest(mode: Request.popular(1), onComplete: { result,err in
                            expect(err).to(beNil())
                            done()
                        })
                        
                    }
                }
                
            }
            
        }
    }

}



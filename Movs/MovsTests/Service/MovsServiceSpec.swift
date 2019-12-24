//
//  MovsServiceSpec.swift
//  MovsTests
//
//  Created by Lucca França Gomes Ferreira on 23/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Quick
import Nimble
import Combine
@testable import Movs

class MovsServiceSpec: QuickSpec {

    override func spec() {
        describe("MovsService") {
            context("when popularMovies is called") {
                var responseCancellable: AnyCancellable?
                it("should return some response") {
                    waitUntil(timeout: 5) { done in
                        responseCancellable = MovsService.shared.popularMovies(fromPage: 1)
                            .sink(receiveCompletion: { (completion) in
                                switch completion {
                                case .failure(let error):
                                    fail(error.localizedDescription)
                                case .finished:
                                    break
                                }
                            }, receiveValue: { (movies) in
                                expect(movies).notTo(beEmpty())
                            })
                        done()
                    }
                }
            }
            
            context("when getMoviePoster is called") {
                context("with a poster path nil") {
                    var responseCancellable: AnyCancellable?
                    it("should respond with a UIImage with a placeholder") {
                        waitUntil(timeout: 5) { done in
                            responseCancellable = MovsService.shared.getMoviePoster(fromPath: nil)
                                .sink(receiveValue: { (image) in
                                    expect(image.pngData()).to(equal(UIImage(named: "imagePlaceholder")?.pngData()))
                                })
                            done()
                        }
                    }
                }
                context("with a not nil poster path") {
                    var responseCancellable: AnyCancellable?
                    it("should respond with the correspondent UIImage") {
                        waitUntil(timeout: 5) { done in
                            responseCancellable = MovsService.shared.getMoviePoster(fromPath: "/db32LaOibwEliAmSL2jjDF6oDdj.jpg")
                                .sink(receiveValue: { (image) in
                                    expect(image.pngData()).notTo(equal(UIImage(named: "imagePlaceholder")?.pngData()))
                                })
                            done()
                        }
                    }
                }
            }
            
            context("when getGenres is called") {
                var responseCancellable: AnyCancellable?
                it("should respond with an array of Genres") {
                    waitUntil(timeout: 5) { done in
                        responseCancellable = MovsService.shared.getGenres()
                            .sink(receiveValue: { (genres) in
                                expect(genres).notTo(beEmpty())
                            })
                        done()
                    }
                }
            }
            
            context("when getMovie is called") {
                context("with a valid ID") {
                    var responseCancellable: AnyCancellable?
                    it("should respond with a movie") {
                        waitUntil(timeout: 5) { done in
                            responseCancellable = MovsService.shared.getMovie(withId: 181812)
                                .sink(receiveCompletion: { (completion) in
                                    switch completion {
                                    case .failure(let error):
                                        fail(error.localizedDescription)
                                    case .finished:
                                        break
                                    }
                                }, receiveValue: { (movie) in
                                    expect(movie.id).to(equal(181812))
                                })
                            done()
                        }
                    }
                }
                context("with a invalid ID") {
                    var responseCancellable: AnyCancellable?
                    it("should respond with nil") {
                        waitUntil(timeout: 5) { done in
                            responseCancellable = MovsService.shared.getMovie(withId: 1)
                                .sink(receiveCompletion: { (completion) in
                                    switch completion {
                                    case .failure(let error):
                                        fail(error.localizedDescription)
                                    case .finished:
                                        break
                                    }
                                }, receiveValue: { (movie) in
                                    expect(movie.id).to(equal(181812))
                                })
                            done()
                        }
                    }
                }
                
            }
            
        }
    }
    
}

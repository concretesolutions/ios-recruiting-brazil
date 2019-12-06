//
//  DataProviderSpec.swift
//  MovsTests
//
//  Created by Carolina Cruz Agra Lopes on 04/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import Quick
import Nimble
import UIKit

@testable import Movs

class DataProviderSpec: QuickSpec {

    // MARK: - Sut

    private var sut: DataProvider!

    // MARK: - Variables

    private var dataFetcher: MockDataFetcher!

    // MARK: - Tests

    //swiftlint:disable function_body_length
    override func spec() {
        describe("DataProvider") {

            beforeEach {
                self.dataFetcher = MockDataFetcher()
                self.sut = DataProvider.shared
            }

            afterEach {
                self.sut = nil
                self.dataFetcher = nil
                DataProvider.shared.reset()
            }

            // MARK: Before setup

            context("before setup") {

                beforeEach {
                    self.mockData()
                }

                it("should not have any movies") {
                    expect(self.sut.movies.isEmpty) == true
                }

                it("should not be able to get any genre") {
                    waitUntil { done in
                        self.sut.genre(forId: 1) { genre in
                            expect(genre).to(beNil())
                            done()
                        }
                    }
                }

                it("should not be able to get any movies") {
                    waitUntil { done in
                        self.sut.getMoreMovies { error in
                            expect(error).toNot(beNil())
                            done()
                        }
                    }
                }
            }

            // MARK: After setup

            context("after setup") {

                // MARK: With no errors

                context("when the data fetcher doesn't return any errors") {

                    beforeEach {
                        self.mockData()

                        waitUntil { done in
                            self.sut.setup(withDataFetcher: self.dataFetcher) { error in
                                if error != nil {
                                    fail("Expected setup to suceed, but it failed")
                                }

                                done()
                            }
                        }
                    }

                    it("should have the movies from the first page") {
                        if self.sut.movies.count != 2 {
                            fail("Expected the data provider to have exactly 2 movies, but it has \(self.sut.movies.count)")
                        } else {
                            expect(self.sut.movies[0].id) == 1
                            expect(self.sut.movies[0].title) == "Movie_1"
                            expect(self.sut.movies[0].overview) == "Movie_1 overview"
                            expect(self.sut.movies[0].genreIds) == [1]
                            expect(self.sut.movies[0].releaseYear) == "2019"
                            expect(self.sut.movies[0].posterPath) == "/Movie_1.jpg"

                            expect(self.sut.movies[1].id) == 2
                            expect(self.sut.movies[1].title) == "Movie_2"
                            expect(self.sut.movies[1].overview) == "Movie_2 overview"
                            expect(self.sut.movies[1].genreIds) == [4]
                            expect(self.sut.movies[1].releaseYear) == "2010"
                            expect(self.sut.movies[1].posterPath) == "/Movie_2.jpg"
                        }
                    }

                    context("when requesting a genre") {

                        it("should return the genre's name for a valid id") {
                            waitUntil { done in
                                self.sut.genre(forId: 3) { genre in
                                    expect(genre) == "Adventure"
                                    done()
                                }
                            }
                        }

                        it("should return nil for an invalid id") {
                            waitUntil { done in
                                self.sut.genre(forId: 6) { genre in
                                    expect(genre).to(beNil())
                                    done()
                                }
                            }
                        }
                    }

                    it("should be able to get more movies") {
                        waitUntil { done in
                            self.sut.getMoreMovies { error in
                                if error != nil {
                                    fail("Expected call to suceed, but it failed")
                                } else if self.sut.movies.count != 3 {
                                    fail("Expected the data provider to have exactly 3 movies, but it has \(self.sut.movies.count)")
                                } else {
                                    expect(self.sut.movies[2].id) == 3
                                    expect(self.sut.movies[2].title) == "Movie_3"
                                    expect(self.sut.movies[2].overview) == "Movie_3 overview"
                                    expect(self.sut.movies[2].genreIds) == [2, 4]
                                    expect(self.sut.movies[2].releaseYear) == "3000"
                                    expect(self.sut.movies[2].posterPath).to(beNil())

                                    done()
                                }
                            }
                        }
                    }

                    context("when there are no more movies to get") {

                        beforeEach {
                            waitUntil { done in
                                self.sut.getMoreMovies { error in
                                    if error != nil {
                                        fail("Expected call to suceed, but it failed")
                                    } else if self.sut.movies.count != 3 {
                                        fail("Expected the data provider to have exactly 3 movies, but it has \(self.sut.movies.count)")
                                    } else {
                                        done()
                                    }
                                }
                            }
                        }

                        it("should get an error") {
                            waitUntil { done in
                                self.sut.getMoreMovies { error in
                                    expect(error).toNot(beNil())
                                    done()
                                }
                            }
                        }
                    }
                }

                // MARK: With errors

                context("when the data fetcher returns an error") {

                    context("when the error comes from the genre setup") {

                        beforeEach {
                            self.mockMovies()

                            waitUntil { done in
                                self.sut.setup(withDataFetcher: self.dataFetcher) { error in
                                    if error != nil {
                                        fail("Expected setup to suceed, but it failed")
                                    }

                                    done()
                                }
                            }
                        }

                        it("should not be able to get any genre") {
                            waitUntil { done in
                                self.sut.genre(forId: 1) { genre in
                                    expect(genre).to(beNil())
                                    done()
                                }
                            }
                        }
                    }

                    context("when the error comes from the movies setup") {

                        beforeEach {
                            self.mockGenres()

                            waitUntil { done in
                                self.sut.setup(withDataFetcher: self.dataFetcher) { error in
                                    expect(error).toNot(beNil())
                                    done()
                                }
                            }
                        }

                        it("should not be able to get any movies") {
                            waitUntil { done in
                                self.sut.getMoreMovies { error in
                                    expect(error).toNot(beNil())
                                    done()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    //swiftlint:enable function_body_length

    // MARK: - Helpers

    private func mockData() {
        self.mockGenres()
        self.mockMovies()
    }

    private func mockGenres() {
        self.dataFetcher.genres = [
            1: "Action",
            2: "Romance",
            3: "Adventure",
            4: "Comedy",
            5: "Drama"
        ]
    }

    private func mockMovies() {
        self.dataFetcher.movies[1] = [
            PopularMovieDTO(id: 1, title: "Movie_1", overview: "Movie_1 overview", genreIds: [1], releaseDate: "2019", posterPath: "/Movie_1.jpg"),
            PopularMovieDTO(id: 2, title: "Movie_2", overview: "Movie_2 overview", genreIds: [4], releaseDate: "2010", posterPath: "/Movie_2.jpg")
        ]
        self.dataFetcher.movies[2] = [
            PopularMovieDTO(id: 3, title: "Movie_3", overview: "Movie_3 overview", genreIds: [2, 4], releaseDate: "3000", posterPath: nil)
        ]
    }
}

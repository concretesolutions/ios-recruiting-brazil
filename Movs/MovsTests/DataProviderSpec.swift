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
    private var userDefaults: MockUserDefaults!

    // MARK: - Tests

    //swiftlint:disable function_body_length
    override func spec() {
        describe("DataProvider") {

            beforeEach {
                DataProvider.shared.reset()
                self.dataFetcher = MockDataFetcher()
                self.userDefaults = MockUserDefaults()
                self.sut = DataProvider.shared
            }

            afterEach {
                self.sut = nil
                self.userDefaults.clear()
                self.userDefaults = nil
                self.dataFetcher = nil
            }

            // MARK: Before setup

            context("before setup") {

                beforeEach {
                    self.dataFetcher.mockData()
                }

                it("should not have any movies") {
                    expect(self.sut.movies.isEmpty) == true
                }

                it("should not be able to get any genre") {
                    expect(self.sut.genres).to(beEmpty())
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
                        self.dataFetcher.mockData()

                        waitUntil { done in
                            self.sut.setup(withMoviesDataFetcher: self.dataFetcher, andFavoriteIDsDataFetcher: MockUserDefaults()) { error in
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
                            expect(self.sut.movies[0].genres) == [Genre(fromDTO: GenreDTO(id: 1, name: "Action"))]
                            expect(self.sut.movies[0].releaseYear) == "2019"

                            expect(self.sut.movies[1].id) == 2
                            expect(self.sut.movies[1].title) == "Movie_2"
                            expect(self.sut.movies[1].overview) == "Movie_2 overview"
                            expect(self.sut.movies[1].genres) == [Genre(fromDTO: GenreDTO(id: 4, name: "Comedy"))]
                            expect(self.sut.movies[1].releaseYear) == "2010"
                        }
                    }

                    context("when requesting a genre") {

                        it("should return the genre's name for a valid id") {
                            expect(self.sut.genres[3]) == Genre(fromDTO: GenreDTO(id: 3, name: "Adventure"))
                        }

                        it("should return nil for an invalid id") {
                            expect(self.sut.genres[6]).to(beNil())
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
                                    expect(self.sut.movies[2].genres) == [Genre(fromDTO: GenreDTO(id: 2, name: "Romance")), Genre(fromDTO: GenreDTO(id: 4, name: "Comedy"))]
                                    expect(self.sut.movies[2].releaseYear) == "3000"

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
                            self.dataFetcher.mockMovies()

                            waitUntil { done in
                                self.sut.setup(withMoviesDataFetcher: self.dataFetcher, andFavoriteIDsDataFetcher: MockUserDefaults()) { error in
                                    if error != nil {
                                        fail("Expected setup to suceed, but it failed")
                                    }

                                    done()
                                }
                            }
                        }

                        it("should not be able to get any genre") {
                            expect(self.sut.genres[1]).to(beNil())
                        }
                    }

                    context("when the error comes from the movies setup") {

                        beforeEach {
                            self.dataFetcher.mockGenres()

                            waitUntil { done in
                                self.sut.setup(withMoviesDataFetcher: self.dataFetcher, andFavoriteIDsDataFetcher: MockUserDefaults()) { error in
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
}

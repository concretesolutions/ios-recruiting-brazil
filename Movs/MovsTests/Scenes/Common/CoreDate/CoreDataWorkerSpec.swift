//
//  CoreDataWorkerSpec.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class CoreDataWorkerSpec: QuickSpec {
    override func spec() {
        describe("CoreDataWorker Spec") {
            
            var worker: CoreDataWorker!
            
            context("delete") {
                beforeEach {
                    worker = CoreDataWorker()
                }
                
                it("should delete all") {
                    worker.deleteAll()
                    let movies = worker.fetchFavoriteMovies()
                    expect(movies.count).to(equal(0))
                }
            }
            
            context("filter") {
                
                beforeEach {
                    worker = CoreDataWorker()
                }
                
                it("should filter by year") {
                    let movie = Movie(id: 0, genreIds: [],
                                      posterPath: "", overview: "",
                                      releaseDate: "2018-11-01", title: "")
                    let filter = "2018"
                    worker.save(movie: movie)
                    let movies = worker.fetchFilteredYear(filter)
                    worker.delete(movie: movie)
                    expect(movies.count).to(beGreaterThan(0))
                }
                
                it("should filter by genre") {
                    let movie = Movie(id: 0, genreIds: [1],
                                      posterPath: "", overview: "",
                                      releaseDate: "yyyy-", title: "")
                    let filter = "1"
                    worker.save(movie: movie)
                    let movies = worker.fetchFilteredGenre(filter)
                    worker.delete(movie: movie)
                    expect(movies.count).to(beGreaterThan(0))
                }
                
                it("should filter by year and genre") {
                    let movie = Movie(id: 0, genreIds: [1],
                                      posterPath: "", overview: "",
                                      releaseDate: "2018-11-01", title: "")
                    let year = "2018"
                    let genre = "1"
                    worker.save(movie: movie)
                    let movies = worker.fetchMoviesFiltered(by: year, by: genre)
                    worker.delete(movie: movie)
                    expect(movies.count).to(beGreaterThan(0))
                }
            }
            
        }
    }
}


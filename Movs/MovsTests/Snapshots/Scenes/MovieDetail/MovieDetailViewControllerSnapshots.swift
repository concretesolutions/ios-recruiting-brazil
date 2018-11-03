//
//  MovieDetailViewControllerSnapshots.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Movs

class MovieDetailViewControllerSnapshots: QuickSpec {
    override func spec() {
        describe("MovieViewController Snapshots") {
            context("empty view controller") {
                it("should have table view and favorite button") {
                    let movie = Movie(id: 0, genreIds: [],
                                      posterPath: "", overview: "",
                                      releaseDate: "", title: "")
                    let viewController = MovieDetailViewController(movie: movie)
                    expect(viewController.view) == snapshot("MovieDetailViewController")
                }
            }
        }
    }
}


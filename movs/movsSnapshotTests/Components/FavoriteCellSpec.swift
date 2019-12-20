//
//  FavoriteCellSpec.swift
//  movsSnapshotTests
//
//  Created by Emerson Victor on 17/12/19.
//  Copyright © 2019 emer. All rights reserved.
//
// swiftlint:disable line_length

import Quick
import Nimble
import Nimble_Snapshots
import UIKit
@testable import Movs

class FavoriteMovieCellSpec: QuickSpec {
    override func spec() {
        describe("FavoriteCell") {
            var view: FavoriteMovieCell!
            var movie: Movie!
            
            beforeEach {
                view = FavoriteMovieCell()
                view.frame = CGRect(x: 0, y: 0, width: 400, height: 176)
                let movieDetailDTO = MovieDetailDTO(id: 10,
                                                    title: "Movie title",
                                                    releaseDate: "2010-10-10",
                                                    synopsis: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                                    posterPath: nil,
                                                    genres: [GenreDTO(id: 10,
                                                                      name: "Fantasy")])
                movie = Movie(movie: movieDetailDTO)
            }
            
            it("should have a cool layout") {
                view.setup(with: movie)
                expect(view).to(haveValidSnapshot(named: "FavoriteMovieCell"))
            }
        }
    }
}

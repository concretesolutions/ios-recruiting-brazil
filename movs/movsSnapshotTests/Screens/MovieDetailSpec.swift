//
//  MovieDetailSpec.swift
//  movsSnapshotTests
//
//  Created by Emerson Victor on 17/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
import UIKit
@testable import Movs

class MovieDetailSpec: QuickSpec {
    override func spec() {
        describe("MovieDetail") {
            var view: MovieDetailScreen!
            var movie: Movie!
            
            beforeEach {
                let movieDetailDTO = MovieDetailDTO(id: 10,
                                                    title: "Movie title",
                                                    releaseDate: "2010-10-10",
                                                    synopsis: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                                                    posterPath: nil,
                                                    genres: [GenreDTO(id: 10,
                                                                      name: "Fantasy")])
                movie = Movie(movie: movieDetailDTO)
                view = MovieDetailScreen(movie: movie)
                view.frame = CGRect(x: 0, y: 0, width: 414, height: 813)
            }
            
            it("shouldn't be favorite") {
                view.favoriteButton.isSelected = false
                expect(view).to(haveValidSnapshot(named: "MovieDetail"))
            }
            
            it("should be favorite") {
                view.favoriteButton.isSelected = true
                expect(view).to(haveValidSnapshot(named: "MovieDetailFavorite"))
            }
        }
    }
}

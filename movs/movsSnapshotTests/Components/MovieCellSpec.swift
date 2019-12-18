//
//  MovieCellSpec.swift
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

class MovieCellSpec: QuickSpec {
    override func spec() {
        describe("MovieCell") {
            var view: MovieCell!
            var movie: Movie!
            
            beforeEach {
                view = MovieCell()
                view.frame = CGRect(x: 0, y: 0, width: 200, height: 200*1.5)
                let movieDetailDTO = MovieDetailDTO(id: 10,
                                                    title: "Movie title",
                                                    releaseDate: "2010-10-10",
                                                    synopsis: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                                                    posterPath: nil,
                                                    genres: [GenreDTO(id: 10,
                                                                      name: "Fantasy")])
                movie = Movie(movie: movieDetailDTO)
                
            }
            
            it("shouldn't be favorite") {
                movie.isFavorite = false
                view.setup(with: movie)
                expect(view).to(haveValidSnapshot(named: "MovieCell"))
            }
            
            it("should be favorite") {
                movie.isFavorite = true
                view.setup(with: movie)
                expect(view).to(haveValidSnapshot(named: "MovieCellFavorited"))
            }
        }
    }
}

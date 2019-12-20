//
//  FavoriteMovieCellSpec.swift
//  MovsCodeViewTests
//
//  Created by Carolina Cruz Agra Lopes on 19/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import Movs

class FavoriteMovieCellSpec: QuickSpec {

    // MARK: - Sut

    private var sut: FavoriteMovieCell!

    // MARK: - Variables

    private var movieDTO: PopularMovieDTO!

    // MARK: - Tests

    override func spec() {
        describe("FavoriteMovieCell") {
            beforeEach {
                self.sut = FavoriteMovieCell(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: 130))
                self.movieDTO = PopularMovieDTO(id: 1, title: "Movie title", overview: "The movie's overview", genreIds: [1, 5], releaseDate: "3000", posterPath: nil)
                self.sut.configure(with: Movie(fromDTO: self.movieDTO, smallImageURL: nil, bigImageURL: nil, isFavorite: false))
            }

            afterEach {
                self.movieDTO = nil
                self.sut = nil
            }

            it("should have the expected look and feel") {
                expect(self.sut) == snapshot("FavoriteMovieCell")
            }
        }
    }
}

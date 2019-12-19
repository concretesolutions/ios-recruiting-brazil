//
//  PopularMovieCellSpec.swift
//  MovsCodeViewTests
//
//  Created by Carolina Cruz Agra Lopes on 05/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import Movs

class PopularMovieCellSpec: QuickSpec {

    // MARK: - Sut

    private var sut: PopularMovieCell!

    // MARK: - Variables

    private var movieDTO: PopularMovieDTO!

    // MARK: - Tests

    override func spec() {
        describe("PopularMovieCell") {
            beforeEach {
                self.sut = PopularMovieCell(frame: CGRect(x: 0, y: 0, width: 170, height: 250))
                self.movieDTO = PopularMovieDTO(id: 1, title: "A VERY very big movie title", overview: "The movie's overview", genreIds: [1, 5], releaseDate: "3000", posterPath: nil)
            }

            afterEach {
                self.movieDTO = nil
                self.sut = nil
            }

            context("when configured with a non favorite movie") {

                beforeEach {
                    self.sut.configure(with: Movie(fromDTO: self.movieDTO, smallImageURL: nil, bigImageURL: nil, isFavorite: false))
                }

                it("should have the expected look and feel") {
                    expect(self.sut) == snapshot("PopularMovieCell_nonFavorite")
                }
            }

            context("when configured with a favorite movie") {

                beforeEach {
                    self.sut.configure(with: Movie(fromDTO: self.movieDTO, smallImageURL: nil, bigImageURL: nil, isFavorite: true))
                }

                it("should have the expected look and feel") {
                    expect(self.sut) == snapshot("PopularMovieCell_favorite")
                }
            }

            describe("its heart view") {

                context("when is is tapped on once") {

                    beforeEach {
                        self.sut.configure(with: Movie(fromDTO: self.movieDTO, smallImageURL: nil, bigImageURL: nil, isFavorite: false))
                        self.sut.didTapOnHeart()
                    }

                    it("should change its color") {
                        expect(self.sut) == snapshot("PopularMovieCell_favorite")
                    }
                }

                context("when is is tapped on twice") {

                    beforeEach {
                        self.sut.configure(with: Movie(fromDTO: self.movieDTO, smallImageURL: nil, bigImageURL: nil, isFavorite: false))
                        self.sut.didTapOnHeart()
                        self.sut.didTapOnHeart()
                    }

                    it("should change its color") {
                        expect(self.sut) == snapshot("PopularMovieCell_nonFavorite")
                    }
                }
            }
        }
    }
}

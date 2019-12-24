//
//  FavoriteMoviesViewModelSpec.swift
//  MovsTests
//
//  Created by Lucca França Gomes Ferreira on 22/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Quick
import Nimble
import Combine
@testable import Movs

class FavoriteMoviesViewModelSpec: QuickSpec {

    override func spec() {
        describe("FavoriteMoviesViewModel") {
            var favoriteMoviesViewModel: FavoriteMoviesViewModel!
            context("get a cell") {
                var movieDTO: MovieDTO!
                var movie: Movie!
                beforeEach {
                    movieDTO = MovieDTO(id: 1,
                                        overview: "overview",
                                        releaseDate: "2019-12-18",
                                        genreIds: [1, 2],
                                        title: "title",
                                        posterPath: "posterPath")
                    movie = Movie(withMovie: movieDTO)
                    favoriteMoviesViewModel = FavoriteMoviesViewModel(withFavoriteMovies: [movie])
                }
                context("viewModel") {
                    var viewModel: FavoriteMoviesCellViewModel!
                    beforeEach {
                        viewModel = favoriteMoviesViewModel.viewModelForCell(at: IndexPath(item: 0, section: 0))
                    }
                    it("Instanciate and return the correct PopularMoviesCellViewModel") {
                        expect(viewModel.title).to(equal(movie.title))
                        expect(viewModel.overview).to(equal(movie.overview))
                        expect(viewModel.releaseYear).to(equal("2019"))
                    }
                }
            }
        }
    }

}

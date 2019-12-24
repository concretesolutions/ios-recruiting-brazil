//
//  PopularMoviesViewModelSpec.swift
//  MovsTests
//
//  Created by Lucca França Gomes Ferreira on 19/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Quick
import Nimble
import Combine
@testable import Movs

class PopularMoviesViewModelSpec: QuickSpec {
    
    override func spec() {
        describe("PopularMoviesViewModel") {
            var popularMoviesViewModel: PopularMoviesViewModel!
            beforeEach {
                popularMoviesViewModel = PopularMoviesViewModel()
            }
            context("get a cell") {
                var movieDTO: MovieDTO!
                var movie: Movie!
                beforeEach {
                    movieDTO = MovieDTO(id: 1,
                                        overview: "overview",
                                        releaseDate: "releaseDate",
                                        genreIds: [1, 2],
                                        title: "title",
                                        posterPath: "posterPath")
                    movie = Movie(withMovie: movieDTO)
                    popularMoviesViewModel.popularMovies = [movie]
                }
                context("viewModel") {
                    var viewModel: PopularMoviesCellViewModel!
                    beforeEach {
                        viewModel = popularMoviesViewModel.viewModelForCell(at: IndexPath(item: 0, section: 0))
                    }
                    it("Instanciate and return the correct PopularMoviesCellViewModel") {
                        expect(viewModel.title).to(equal(movie.title))
                        expect(viewModel.posterImageCancellable).to(beAnInstanceOf(AnyCancellable.self))
                        expect(viewModel.isLikedCancellable).to(beAnInstanceOf(AnyCancellable.self))
                    }
                }
                context("viewModelDetails") {
                    var viewModelDetails: MovieDetailsViewModel!
                    beforeEach {
                        viewModelDetails = popularMoviesViewModel.viewModelDetailsForCell(at: IndexPath(item: 0, section: 0))
                    }
                    it("Instanciate and return the correct MovieDetailsViewModel") {
                        expect(viewModelDetails.title).to(equal(movie.title))
                        expect(viewModelDetails.posterImageCancellable).to(beAnInstanceOf(AnyCancellable.self))
                    }
                }
            }
            context("searchCombine") {
                beforeEach {
                    popularMoviesViewModel.setSearchCombine(<#T##publisher: Published<String>.Publisher##Published<String>.Publisher#>)
                }
                it("has a cancellable") {
                    
                }
            }
            context("networkCancellable") {
                beforeEach {
                    popularMoviesViewModel.setNetworkCombine()
                }
                it("has a cancellable") {
                    
                }
            }
            
        }
    }
}

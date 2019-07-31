//
//  MovieDetailsPresenterTests.swift
//  TheMoviesTests
//
//  Created by Matheus Bispo on 7/31/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
import RxSwift
@testable import TheMovies

class MovieDetailsPresenterTests: QuickSpec {
    override func spec() {
        describe("MovieDetail") {
            var presenter: MovieDetailsPresenter!
            var loadMovieDetailUseCaseSpy: UseCaseSpy<Int, [Movie]>!
            var favoriteMovieUseCaseSpy: UseCaseSpy<Int, Movie>!
            
            
            beforeEach {
                loadMovieDetailUseCaseSpy = UseCaseSpy<Int, [Movie]>()
                favoriteMovieUseCaseSpy = UseCaseSpy<Int, Movie>()
                presenter = MovieDetailsPresenter(loadMovieDetailUseCase: loadMovieDetailUseCaseSpy,
                                                  favoriteMovieUseCase: favoriteMovieUseCaseSpy)
            }
            
            afterEach {
                loadMovieDetailUseCaseSpy = nil
                favoriteMovieUseCaseSpy = nil
                presenter = nil
            }
            
            describe("Presenter") {
                it("Deve carregar detalhes de um filme") {
                    presenter.loadMovieDetail(id: 0)
                    expect(loadMovieDetailUseCaseSpy.callRunCount) == 1
                }
                
                it("Deve favoritar o filme da tela") {
                    presenter.favoriteMovieButtonWasTapped(id: 0)
                    expect(favoriteMovieUseCaseSpy.callRunCount) == 1
                }
            }
        }
    }
}


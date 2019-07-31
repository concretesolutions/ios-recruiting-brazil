//
//  MoviesGridPresenterTests.swift
//  TheMoviesTests
//
//  Created by Matheus Bispo on 7/31/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
import RxSwift
import UIKit
import Swinject
@testable import TheMovies

class MoviesGridPresenterTests: QuickSpec {
    override func spec() {
        describe("MoviesGrid") {
            var presenter: MoviesGridPresenter!
            var loadMoviesFromNetworkUseCaseSpy: UseCaseSpy<Void, [Movie]>!
            var showMovieDetailsUseCaseSpy: UseCaseSpy<Int, Bool>!
            var loadGenresAndCacheUseCaseSpy: UseCaseSpy<Void, Bool>!
            var loadMoviesFromCacheUseCaseSpy: UseCaseSpy<Void, [Movie]>!
            
            
            beforeEach {
                loadMoviesFromNetworkUseCaseSpy = UseCaseSpy()
                showMovieDetailsUseCaseSpy = UseCaseSpy()
                loadGenresAndCacheUseCaseSpy = UseCaseSpy()
                loadMoviesFromCacheUseCaseSpy = UseCaseSpy()
                presenter = MoviesGridPresenter(loadMoviesUseCase: loadMoviesFromNetworkUseCaseSpy,
                                                showMovieDetailsUseCase: showMovieDetailsUseCaseSpy,
                                                loadGenresAndCacheUseCase: loadGenresAndCacheUseCaseSpy,
                                                loadMoviesFromCacheUseCase: loadMoviesFromCacheUseCaseSpy)
            }
            
            afterEach {
                loadMoviesFromNetworkUseCaseSpy = nil
                showMovieDetailsUseCaseSpy = nil
                loadGenresAndCacheUseCaseSpy = nil
                loadMoviesFromCacheUseCaseSpy = nil
                presenter = nil
            }
            
            describe("Presenter") {
                it("Deve carregar filmes da API") {
                    presenter.loadNewPageMoviesFromNetwork()
                    expect(loadMoviesFromNetworkUseCaseSpy.callRunCount) == 1
                }
                
                it("Deve carregar filmes do cache") {
                    presenter.movieCellWasTapped(id: 0)
                    expect(showMovieDetailsUseCaseSpy.callRunCount) == 1
                }
                
                it("Carregar generos da API e guardar em cache") {
                    presenter.cacheGenres()
                    expect(loadGenresAndCacheUseCaseSpy.callRunCount) == 1
                }
                
                it("Deve carregar filmes da memória local") {
                    presenter.loadMoviesFromCache()
                    expect(loadMoviesFromCacheUseCaseSpy.callRunCount) == 1
                }
            }
        }
    }
}

//
//  FavoriteMoviesPresenterTests.swift
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

class FavoriteMoviesPresenterTests: QuickSpec {
    override func spec() {
        describe("FavoriteMovies") {
            var presenter: FavoriteMoviesPresenter!
            var loadFavoriteMoviesUseCase: UseCaseSpy<[Movie], [Movie]>!
            var favoriteMovieUseCase: UseCaseSpy<Int, Movie>!
            var loadMoviesYearUseCase: UseCaseSpy<Void, Set<String>>!
            var loadGenresFromCacheUseCase: UseCaseSpy<Void, [Genre]>!
            
            beforeEach {
                loadFavoriteMoviesUseCase = UseCaseSpy<[Movie], [Movie]>()
                favoriteMovieUseCase = UseCaseSpy<Int, Movie>()
                loadMoviesYearUseCase = UseCaseSpy<Void, Set<String>>()
                loadGenresFromCacheUseCase = UseCaseSpy<Void, [Genre]>()
                
                presenter = FavoriteMoviesPresenter(loadFavoriteMoviesUseCase: loadFavoriteMoviesUseCase,
                                                    favoriteMovieUseCase: favoriteMovieUseCase,
                                                    loadMoviesYearUseCase: loadMoviesYearUseCase,
                                                    loadGenresFromCacheUseCase: loadGenresFromCacheUseCase)
            }
            
            afterEach {
                loadFavoriteMoviesUseCase = nil
                favoriteMovieUseCase = nil
                loadMoviesYearUseCase = nil
                loadGenresFromCacheUseCase = nil
                presenter = nil
            }
            
            describe("Presenter") {
                it("Deve carregar os Anos dos filmes da memoria") {
                    presenter.loadMoviesYear()
                    expect(loadMoviesYearUseCase.callRunCount) == 1
                }
                
                it("Deve carregar os generos da memoria") {
                    presenter.loadMoviesGenres()
                    expect(loadGenresFromCacheUseCase.callRunCount) == 1
                }
                
                it("Deve carregar todos os favoritos da memoria") {
                    presenter.loadFavoriteMovies()
                    expect(loadFavoriteMoviesUseCase.callRunCount) == 1
                }
                
                it("Deve favoritar o filme da tela") {
                    presenter.unfavoriteMovieButtonWasTapped(id: 0)
                    expect(favoriteMovieUseCase.callRunCount) == 1
                }
            }
        }
    }
}

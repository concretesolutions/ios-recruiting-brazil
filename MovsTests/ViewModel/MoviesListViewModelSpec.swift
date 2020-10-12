//
//  MoviesListViewModelSpec.swift
//  MovsTests
//
//  Created by Joao Lucas on 09/10/20.
//

import Quick
import Nimble
import RealmSwift
@testable import Movs

class MoviesListViewModelSpec: QuickSpec {
    override func spec() {
        describe("MoviesListViewModel Spec") {
            
            var client: HTTPClientMock!
            var service: MoviesListService!
            var viewState: ViewState<MoviesDTO, HTTPError>!
            var viewStateGenre: ViewState<GenresDTO, HTTPError>!
            var useCase: MoviesListUseCaseMock!
            var viewModel: MoviesListViewModel!
            var state: MoviesListState!
            
            let realm = try! Realm()
            
            beforeEach {
                client = HTTPClientMock()
                service = MoviesListService(client: client)
                viewState = ViewState<MoviesDTO, HTTPError>()
                viewStateGenre = ViewState<GenresDTO, HTTPError>()
                useCase = MoviesListUseCaseMock()
                viewModel = MoviesListViewModel(service: service, viewState: viewState, viewStateGenre: viewStateGenre, useCase: useCase)
                state = MoviesListState()
            }
            
            it("Verify fetch movies list with success") {
                client.fileName = "popular-movies"
                
                viewModel.fetchMoviesList()
                    .successObserver(state.onSuccess)
                    .loadingObserver(state.onLoading)
                    .errorObserver(state.onError)
                
                expect(state.success).to(beTrue())
            }
            
            it("Verify load add to favorite") {
                var successAdding = false
                let movies = ResultMoviesDTO(id: 1, title: "Title", poster_path: "www.google.com", genre_ids: [1, 2, 3])
                
                viewModel.successAdding.observer(viewModel) { _ in
                    successAdding = true
                }
                
                viewModel.loadAddToFavorite(realm: realm, movie: movies)
                
                expect(successAdding).to(beTrue())
            }
            
            it("Verify load remove favorite") {
                var successRemoving = false
                let movies = ResultMoviesDTO(id: 1, title: "Title", poster_path: "www.google.com", genre_ids: [1, 2, 3])
                
                viewModel.successRemoving.observer(viewModel) { _ in
                    successRemoving = true
                }
                
                viewModel.loadRemoveFavorite(realm: realm, movie: movies)
                
                expect(successRemoving).to(beTrue())
            }
        }
    }
}

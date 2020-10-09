//
//  MoviesListViewModelSpec.swift
//  MovsTests
//
//  Created by Joao Lucas on 09/10/20.
//

import Quick
import Nimble
@testable import Movs

class MoviesListViewModelSpec: QuickSpec {
    override func spec() {
        describe("MoviesListViewModel Spec") {
            
            var client: HTTPClientMock!
            var service: MoviesListService!
            var viewState: ViewState<MoviesDTO, HTTPError>!
            var viewModel: MoviesListViewModel!
            var state: MoviesListState!
            
            beforeEach {
                client = HTTPClientMock()
                service = MoviesListService(client: client)
                viewState = ViewState<MoviesDTO, HTTPError>()
                viewModel = MoviesListViewModel(service: service, viewState: viewState)
                state = MoviesListState()
            }
            
            it("Verify fetch movies list with success") {
                viewModel.fetchMoviesList()
                    .successObserver(state.onSuccess)
                    .loadingObserver(state.onLoading)
                    .errorObserver(state.onError)
                
                expect(state.success).to(beTrue())
            }
        }
    }
}

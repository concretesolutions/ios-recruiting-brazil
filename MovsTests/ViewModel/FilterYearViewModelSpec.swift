//
//  FilterYearViewModelSpec.swift
//  MovsTests
//
//  Created by Joao Lucas on 15/10/20.
//

import Quick
import Nimble
@testable import Movs

class FilterYearViewModelSpec: QuickSpec {
    override func spec() {
        describe("FilterYearViewModel Spec") {
            
            var client: HTTPClientMock!
            var service: MoviesListService!
            var viewState: ViewState<MoviesDTO, HTTPError>!
            var viewModel: FilterYearViewModel!
            var state: MoviesListState!
            
            beforeEach {
                client = HTTPClientMock()
                service = MoviesListService(client: client)
                viewState = ViewState<MoviesDTO, HTTPError>()
                viewModel = FilterYearViewModel(service: service, viewState: viewState)
                state = MoviesListState()
            }
            
            it("Verify fetch years list with success") {
                client.fileName = "popular-movies"
                
                viewModel.fetchYearsList()
                    .successObserver(state.onSuccess)
                    .loadingObserver(state.onLoading)
                    .errorObserver(state.onError)
                
                expect(state.success).to(beTrue())
            }
        }
    }
}

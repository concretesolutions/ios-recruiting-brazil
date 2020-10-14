//
//  DetailsViewModelSpec.swift
//  MovsTests
//
//  Created by Joao Lucas on 14/10/20.
//

import Quick
import Nimble
import RealmSwift
@testable import Movs

class DetailsViewModelSpec: QuickSpec {
    override func spec() {
        describe("DetailsViewModel Spec") {
            
            var useCase: MoviesListUseCaseMock!
            var viewModel: DetailsViewModel!
            
            let realm = try! Realm()
            
            beforeEach {
                useCase = MoviesListUseCaseMock()
                viewModel = DetailsViewModel(useCase: useCase)
            }
            
            it("Verify load add to favorite") {
                var successAdding = false
                let movies = ResultMoviesDTO(id: 1, title: "Title", poster_path: "www.google.com", genre_ids: [1, 2, 3], release_date: "2020-02-19", overview: "Overview film")
                
                viewModel.successAdding.observer(viewModel) { _ in
                    successAdding = true
                }
                
                viewModel.loadAddToFavorite(realm: realm, movie: movies)
                
                expect(successAdding).to(beTrue())
            }
            
            it("Verify load remove favorite") {
                var successRemoving = false
                let movies = ResultMoviesDTO(id: 1, title: "Title", poster_path: "www.google.com", genre_ids: [1, 2, 3], release_date: "2020-02-19", overview: "Overview film")
                
                viewModel.successRemoving.observer(viewModel) { _ in
                    successRemoving = true
                }
                
                viewModel.loadRemoveFavorite(realm: realm, movie: movies)
                
                expect(successRemoving).to(beTrue())
            }
        }
    }
}

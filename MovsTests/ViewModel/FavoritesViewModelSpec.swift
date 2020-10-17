//
//  FavoritesViewModelSpec.swift
//  MovsTests
//
//  Created by Joao Lucas on 17/10/20.
//

import Quick
import Nimble
import RealmSwift
@testable import Movs

class FavoritesViewModelSpec: QuickSpec {
    override func spec() {
        describe("FavoritesViewModel Spec") {
            
            var useCase: FavoritesUseCaseMock!
            var viewModel: FavoritesViewModel!
            var realm: Realm!
            
            beforeEach {
                useCase = FavoritesUseCaseMock()
                viewModel = FavoritesViewModel(useCase: useCase)
                realm = try! Realm()
            }
            
            it("Verify load remove to favorite") {
                var remove = false
                
                let item = FavoriteEntity()
                item.id = 1
                item.title = "Movie One"
                item.photo = "www.movieone.com/photo"
                item.genre = "Action"
                item.year = "1970"
                item.overview = "Movies one overview"
                
                let indexPath = IndexPath()
                
                viewModel.successRemove.observer(viewModel) { _ in
                    remove = true
                }
                
                viewModel.fetchRemove(realm: realm, item: item, index: indexPath)
                
                expect(remove).to(beTrue())
            }
        }
    }
}

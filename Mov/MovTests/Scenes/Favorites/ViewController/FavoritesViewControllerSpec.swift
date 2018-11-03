//
//  FavoritesViewControllerSpec.swift
//  MovTests
//
//  Created by Miguel Nery on 03/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Quick
import Nimble

@testable import Mov

class FavoritesViewControllerSpec: QuickSpec {
    override func spec() {
        describe("Favorites view controller") {
            var vc: FavoritesViewController!
            
            context("when initialized") {
                var interactor: FavoritesInteractorMock!
                
                beforeEach {
                    interactor = FavoritesInteractorMock()
                    vc = FavoritesViewController()
                    vc.interactor = interactor
                }
                
                it("should fetch favorite") {
                    expect(interactor.didCall(method: .fetchFavorites)).to(beTrue())
                }
                
                it("should set own title") {
                    expect(vc.title).to(equal(FavoritesViewController.title))
                }
                
                it("should add FavoritesView") {
                    expect(vc.view.subviews).to(contain(vc.favoritesView))
                }
                
                it("should enter tableV view state") {
                    expect(vc.state).to(equal(FavoritesViewController.FavoritesState.tableView))
                }
                
                context("and display favorites") {
                    let expectedViewModels = Array(repeating: FavoritesViewModel.placeHolder, count: 5)
                    let expectedState = FavoritesViewController.FavoritesState.tableView
                    
                    beforeEach {
                        vc.display(movies: expectedViewModels)
                    }
                    
                    it("should fetch favorites") {
                        expect(interactor.didCall(method: .fetchFavorites)).to(beTrue())
                    }
                    
                    it("should enter table view state") {
                        expect(vc.state).to(equal(expectedState))
                    }
                    
                    it("should feed view controller with viewModels") {
                        expect(vc.viewModels).to(equal(expectedViewModels))
                    }
                    
                    it("should show table view view") {
                        expect(vc.favoritesView.tableView.isHidden).to(beFalse())
                    }
                }
                
                context("and display no results on search") {
                    let searchRequest = "movieTitle"
                    let expectedState = FavoritesViewController.FavoritesState.noResults(searchRequest)
                    
                    beforeEach {
                        vc.displayNoResults(for: searchRequest)
                    }
                    
                    it("should enter no results state") {
                        expect(vc.state).to(equal(expectedState))
                    }
                    
                    it("should show no results view") {
                        expect(vc.favoritesView.noResultsView.isHidden).to(beFalse())
                    }
                    
                    it("should display search request on no results view") {
                        expect(vc.favoritesView.noResultsView.errorLabel.text).to(equal(Texts.noResults(for: searchRequest)))
                    }
                }
                
                context("and view will appear") {
                    beforeEach {
                        vc.viewWillAppear(true)
                    }
                    
                    it("fetch favorites") {
                        expect(interactor.didCall(method: .fetchFavorites)).to(beTrue())
                    }
                }
            }
        }
    }
}

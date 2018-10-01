//
//  FavoriteMoveisListViewModelSpec.swift
//  ios-recruiting-brazilTests
//
//  Created by André Vieira on 01/10/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import ios_recruiting_brazil

class FavoriteMoveisListViewModelSpec: QuickSpec {
    
    private var viewModel: FavoriteMoveisListViewModelType!
    private var service: MockFavoriteMoviesListService!
    
    override func spec() {
        
        describe("FavoriteMoveisListViewModelSpec - ") {
            beforeEach {
                self.service = MockFavoriteMoviesListService()
                self.viewModel = FavoriteMoveisListViewModel(service: self.service)
            }
            
            it("Should not call remove method", closure: {
                expect(self.service.callRemoveMethod).to(equal(false))
            })
            
            it("favorite movie list should be not empty") {
                expect(self.viewModel.favorites.value.count).to(equal(2))
            }
            
            it("favorite movie list should be empty") {
                self.service.simuleSccuss = false
                self.viewModel.fetchFavorites()
                expect(self.viewModel.favorites.value.count).to(equal(0))
            }
            
            it("favorite movie list should be empty") {
                
                self.viewModel.removeFavorite(index: 1)
                expect(self.service.callRemoveMethod).to(equal(true))
            }
        }
    }
}

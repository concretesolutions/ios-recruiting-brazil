//
//  FavoriteListViewModelSpec.swift
//  moviesTests
//
//  Created by Jacqueline Alves on 16/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class FavoriteListViewModelSpec: QuickSpec {
    override func spec() {
        let sut: FavoriteListViewModel = FavoriteListViewModel(dataProvider: MockedDataProvider.shared)
        
        describe("the 'Favorite List' view model") {
            context("when filter array of movies ") {
                var filteredMovies = [Movie]()
                
                context("with more than one match ") {
                    beforeEach {
                        filteredMovies = sut.filterArray(sut.dataProvider.popularMovies, with: "The")
                    }
                    
                    it("should return two movies.") {
                        expect(filteredMovies.count).to(be(2))
                    }
                }
                
                context("with no matches ") {
                    beforeEach {
                        filteredMovies = sut.filterArray(sut.dataProvider.popularMovies, with: "Captain")
                    }
                    
                    it("should return two movies.") {
                        expect(filteredMovies.count).to(be(0))
                    }
                }
            }
        }
    }
}

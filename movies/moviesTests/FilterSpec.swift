//
//  FilterSpec.swift
//  moviesTests
//
//  Created by Jacqueline Alves on 16/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class FilterSpec: QuickSpec {
    override func spec() {
        describe("the 'Filter' ") {
            var filteredMovies: [Movie] = []
            
            context("when by date ") {
                beforeEach {
                    let options = ["1989", "2010", "2009", "2016"]
                    let sut = ReleaseDateFilter(withOptions: options)
                    sut.selected.send([3])
                    
                    filteredMovies = sut.filter(MockedDataProvider.shared.popularMovies)
                }
                
                it("should return two movies.") {
                    expect(filteredMovies.count).to(be(2))
                }
            }
            
            context("when by genres ") {
                beforeEach {
                    let options = ["Animation", "Comedy", "Adventure", "Drama"]
                    let sut = GenreFilter(withOptions: options, dict: MockedDataProvider.shared.genres)
                    sut.selected.send([1, 2])
                    
                    filteredMovies = sut.filter(MockedDataProvider.shared.popularMovies)
                }
                
                it("should return three movies.") {
                    expect(filteredMovies.count).to(be(3))
                }
            }
        }
    }
}

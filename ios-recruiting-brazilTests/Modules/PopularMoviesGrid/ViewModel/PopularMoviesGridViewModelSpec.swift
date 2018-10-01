//
//  PopularMoviesGridViewModelSpec.swift
//  ios-recruiting-brazilTests
//
//  Created by André Vieira on 01/10/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import ios_recruiting_brazil

class PopularMoviesGridViewModelSpec: QuickSpec {
    
    private var viewModel: PopularMoviesGridViewModelType!
    
    override func spec() {
        
        describe("PopularMoviesGridViewModelSpec - ViewModel Inital State") {
            beforeEach {
                let service = MockPupolarMoviesGridService()
                self.viewModel = PopularMoviesGridViewModel(service: service)
            }
            it("movies") {
                expect(self.viewModel.movies.value.count).to(equal(0))
            }
            it("showLoading", closure: {
                expect(self.viewModel.showLoading.value).to(equal(false))
            })
            it("error", closure: {
                expect(self.viewModel.error.value).to(beNil())
            })
        }
        
        describe("PopularMoviesGridViewModelSpec - Popular Movies grid") {
            beforeEach {
                let service = MockPupolarMoviesGridService()
                self.viewModel = PopularMoviesGridViewModel(service: service)
                self.viewModel.fetchMovies(search: nil)
            }
            
            it("movies") {
                expect(self.viewModel.movies.value.count).to(equal(5))
            }
            
            it("showLoading", closure: {
                expect(self.viewModel.showLoading.value).to(equal(false))
            })
            
            it("error", closure: {
                expect(self.viewModel.error.value).to(beNil())
            })
        }
        
        describe("PopularMoviesGridViewModelSpec - Popular Movies With Filter") {
            beforeEach {
                let service = MockPupolarMoviesGridService()
                self.viewModel = PopularMoviesGridViewModel(service: service)
                self.viewModel.fetchMovies(search: "batman")
            }
            
            it("movies") {
                expect(self.viewModel.movies.value.count).to(equal(5))
            }
            
            it("movie contains the filter") {
                expect(self.viewModel.movies.value[0].title).to(contain("Batman"))
            }
            
            it("showLoading", closure: {
                expect(self.viewModel.showLoading.value).to(equal(false))
            })
            
            it("error", closure: {
                expect(self.viewModel.error.value).to(beNil())
            })
        }
    }
}

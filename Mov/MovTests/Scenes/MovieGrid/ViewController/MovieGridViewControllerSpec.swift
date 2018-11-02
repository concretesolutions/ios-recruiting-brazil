//
//  DefaultMovieGridViewControllerSpec.swift
//  MovTests
//
//  Created by Miguel Nery on 28/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Quick
import Nimble

@testable import Mov


class MovieGridViewControllerSpec: QuickSpec {
    override func spec() {
        describe("the MovieGrid ViewController") {
            context("when initialized") {
                var interactor: MovieGridInteractorMock!
                var vc: MovieGridViewController!
                beforeEach {
                    interactor = MovieGridInteractorMock()
                    vc = MovieGridViewController()
                    
                    vc.interactor = interactor
                }
                
                it ("fetch movies") {
                   expect(interactor.didCall(method: .fetchMovieLit)).to(beTrue())
                }
                
                context("and display movies") {
                    var viewModels: [MovieGridViewModel]!
                    let expectedState = MovieGridViewController.MovieGridState.collection
                        
                    beforeEach {
                        viewModels = Array(repeating: MovieGridViewModel.placeHolder, count: 5)
                        vc.display(movies: viewModels)
                    }
                    
                    it("fetch movies") {
                        expect(interactor.didCall(method: .fetchMovieLit)).to(beTrue())
                    }
                    
                    it("enter collection state") {
                        expect(vc.state).to(equal(expectedState))
                    }
                    
                    it("feed data source with viewModels") {
                        expect(vc.dataSource.viewModels).to(equal(viewModels))
                    }
                }
                
                context("and display network error") {
                    let expectedState = MovieGridViewController.MovieGridState.error
                    
                    beforeEach {
                        vc.displayNetworkError()
                    }
                    
                    it("ente error state") {
                        expect(vc.state).to(equal(expectedState))
                    }
                }
                
            }
        }
    }
}

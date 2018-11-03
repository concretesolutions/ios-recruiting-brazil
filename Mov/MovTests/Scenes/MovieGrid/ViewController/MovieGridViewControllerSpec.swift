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
        describe("MovieGrid ViewController") {
            var vc: MovieGridViewController!
            
            context("when initialized") {
                var interactor: MovieGridInteractorMock!
                beforeEach {
                    interactor = MovieGridInteractorMock()
                    vc = MovieGridViewController()
                    
                    vc.interactor = interactor
                }
                
                it("should set own title") {
                    expect(vc.title).to(equal(MovieGridViewController.title))
                }
                
                it("should add MovieGridView") {
                    expect(vc.view.subviews).to(contain(vc.movieGridView))
                }
                
                it("should enter collection state") {
                    expect(vc.state).to(equal(MovieGridViewController.MovieGridState.collection))
                }
                
                context("and will appear") {
                    beforeEach {
                        vc.viewWillAppear(false)
                    }
                    
                    it("should fetch movies") {
                        expect(interactor.didCall(method: .fetchMovieLit)).to(beTrue())
                    }
                }
                
                context("and display movies") {
                    var expectedViewModels: [MovieGridViewModel]!
                    let expectedState = MovieGridViewController.MovieGridState.collection
                        
                    beforeEach {
                        expectedViewModels = Array(repeating: MovieGridViewModel.placeHolder, count: 5)
                        vc.display(movies: expectedViewModels)
                    }
                    
                    it("should enter collection state") {
                        expect(vc.state).to(equal(expectedState))
                    }
                    
                    it("should feed view controller with viewModels") {
                        expect(vc.viewModels).to(equal(expectedViewModels))
                    }
                    
                    it("should show collection view") {
                        expect(vc.movieGridView.collection.isHidden).to(beFalse())
                    }
                }
                
                context("and display network error") {
                    let expectedState = MovieGridViewController.MovieGridState.error
                    
                    beforeEach {
                        vc.displayNetworkError()
                    }
                    
                    it("should enter error state") {
                        expect(vc.state).to(equal(expectedState))
                    }
                    
                    it("should show error view") {
                        expect(vc.movieGridView.networkErrorView.isHidden).to(beFalse())
                    }
                }
                
                context("and display no results on search") {
                    let searchRequest = "movieTitle"
                    let expectedState = MovieGridViewController.MovieGridState.noResults(searchRequest)
                    
                    beforeEach {
                        vc.displayNoResults(for: searchRequest)
                    }
                    
                    it("should enter no results state") {
                        expect(vc.state).to(equal(expectedState))
                    }
                    
                    it("should show no results view") {
                        expect(vc.movieGridView.noResultsView.isHidden).to(beFalse())
                    }
                    
                    it("should display search request on no results view") {
                        expect(vc.movieGridView.noResultsView.errorLabel.text).to(equal(Texts.noResults(for: searchRequest)))
                    }
                }
            }
        }
    }
}

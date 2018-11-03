//
//  MovieDetailsViewControllerSpec.swift
//  MovTests
//
//  Created by Miguel Nery on 03/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Quick
import Nimble

@testable import Mov

class MovieDetailsViewControllerSpec: QuickSpec {
    override func spec() {
        describe("MovieDetais view controller") {
            var vc: MovieDetailsViewController!
            
            context("when initialized") {
                var interactor: MovieDetailsInteractorMock!
                let movie = Movie.mock(id: 1)
                
                beforeEach {
                    interactor = MovieDetailsInteractorMock()
                    vc = MovieDetailsViewController(movie: movie)
                    vc.interactor = interactor
                }
                
                it("should assing itself the init movie") {
                    expect(vc.movie).to(equal(movie))
                }
                
                it("should getDetails of movie") {
                    expect(interactor.didCall(method: .getDetails)).to(beTrue())
                }
                
                it("should set view as BlankView") {
                    expect(vc.view as? BlankView).notTo(beNil())
                }
                    
                it("should add MovieDetailsView") {
                    expect(vc.view.subviews).to(contain(vc.movieDetailsview))
                }
                
                context("and toggle favorite") {
                    beforeEach {
                        vc.toggleFavorite()
                    }
                    
                    it("should call interactor for toggle favorite") {
                        expect(interactor.didCall(method: .toggleFavorite)).to(beTrue())
                    }
                }
                
                context("and display details") {
                    let unitMock = MovieDetailsUnit(fromMovie: movie, isFavorite: false, genres: [])
                    let expectedViewModel = MovieDetailsViewModel(from: unitMock)
                    beforeEach {
                        vc.displayDetails(of: expectedViewModel)
                    }
                    
                    it("should set self view model") {
                        expect(vc.viewModel).to(equal(expectedViewModel))
                    }
                }
            }
        }
    }
}

//
//  MovieListPresenterSpec.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class MovieListPresenterSpec: QuickSpec {
    override func spec() {
        describe("MovieListPresenter Spec") {
            
            var presenter: MovieListPresenter!
            var viewController: MovieListViewController!
            
            context("error") {
                
                beforeEach {
                    viewController = MovieListViewController()
                    presenter = MovieListPresenter()
                    presenter.viewController = viewController
                }
                
                it("should made view controller be in error state") {
                    let response = MovieList.Response(movies: [], error: "error")
                    presenter.presentError(response: response)
                    expect(viewController.stateMachine.currentState).to(beAKindOf(MovieListErrorState.self))
                }
            }
            
        }
    }
}


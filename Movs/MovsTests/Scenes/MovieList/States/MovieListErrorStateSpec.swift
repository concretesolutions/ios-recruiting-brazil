//
//  MovieListErrorStateSpec.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class MovieListErrorStateSpec: QuickSpec {
    override func spec() {
        describe("MovieListErrorState Spec") {
            
            var state: MovieListErrorState!
            
            context("valid next state") {
                
                beforeEach {
                    let viewController = MovieListViewController()
                    state = MovieListErrorState(viewController: viewController)
                }
                
                it("should be true") {
                    expect(state.isValidNextState(MovieListDisplayState.self)).to(beTrue())
                    expect(state.isValidNextState(MovieListLoadingState.self)).to(beTrue())
                }
            }
        }
    }
}


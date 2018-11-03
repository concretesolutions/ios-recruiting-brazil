//
//  MovieListViewControllerSnapshots.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Movs

class MovieListViewControllerSnapshots: QuickSpec {
    override func spec() {
        describe("MovieListViewController Snapshots") {
            
            context("empty view controller") {
                
                it("should have search bar") {
                    let viewController = MovieListViewController(nibName: nil, bundle: nil)
                    expect(viewController.view) == snapshot("MovieListViewController")
                }
                
            }
            
            context("error") {
                
                var view: MovieListErrorView!
                
                beforeEach {
                    view = MovieListErrorView(frame: UIScreen.main.bounds)
                }
                
                it("should pass with error") {
                    view.setError(viewError: MovieListErrorView.ViewError(movieTitle: "", errorType: .error))
                    expect(view) == snapshot("MovieListViewControllerError")
                }
                
                it("should pass with not find") {
                    view.setError(viewError: MovieListErrorView.ViewError(movieTitle: "Movie", errorType: .notFind))
                    expect(view) == snapshot("MovieListViewControllerNotFind")
                }
            }
        }
    }
}


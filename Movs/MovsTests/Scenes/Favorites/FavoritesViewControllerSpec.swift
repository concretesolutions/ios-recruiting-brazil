//
//  FavoritesViewControllerSpec.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class FavoritesViewControllerSpec: QuickSpec {
    override func spec() {
        describe("FavoritesViewController Spec") {
            
            context("init with decoder") {
                
                it("should raise exception") {
                    let archiver = NSKeyedArchiver(requiringSecureCoding: false)
                    expect(FavoritesViewController(coder: archiver)).to(raiseException())
                }
                
            }
            
            context("init with nib and bundle nil") {
                
                var viewController: FavoritesViewController!
                
                beforeEach {
                    viewController = FavoritesViewController(nibName: nil, bundle: nil)
                }
                
                it("should not be nil") {
                    expect(viewController).toNot(beNil())
                }
                
                it("should not fetch movies") {
                    viewController.isApplyingFilters = true
                    viewController.viewWillAppear(true)
                    expect(viewController.movies.count).to(equal(0))
                }
                
                it("should filter with no name") {
                    viewController.filterMovies(named: "")
                    expect(viewController.movies.count).to(equal(0))
                }
                
                it("should filter no movie") {
                    viewController.filterMovies(named: "nomovie")
                    expect(viewController.movies.count).to(equal(0))
                }
                
                it("should apply filters") {
                    viewController.applyFilters(movies: [])
                    expect(viewController.movies.count).to(equal(0))
                }
                
                it("should remove filters") {
                    viewController.removeFilters()
                    expect(viewController.dateFilter).to(beNil())
                    expect(viewController.genreFilter).to(beNil())
                }
                
                it("should not activate any filter") {
                    viewController.activeFilters(date: nil, genre: nil)
                    expect(viewController.dateFilter).to(beNil())
                    expect(viewController.genreFilter).to(beNil())
                }
                
            }
        }
    }
}


//
//  MovieListViewControllerSearchBarDelegateSpec.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class MovieListViewControllerSearchBarDelegateSpec: QuickSpec {
    override func spec() {
        describe("MovieListViewControllerSearchBarDelegate Spec") {
            
            var viewController: MovieListViewController!
            var searchBar: SearchBar!
            
            context("delegate") {
                
                beforeEach {
                    viewController = MovieListViewController(nibName: nil, bundle: nil)
                    searchBar = viewController.searchBar
                }
                
                it("did begin editing") {
                    viewController.searchBarTextDidBeginEditing(searchBar)
                    expect(searchBar.showsCancelButton).to(beTrue())
                }
                
                it("did end editing") {
                    viewController.searchBarTextDidEndEditing(searchBar)
                    expect(searchBar.showsCancelButton).to(beFalse())
                }
                
                it("search button clicked") {
                    viewController.searchBarSearchButtonClicked(searchBar)
                    expect(searchBar.isFirstResponder).to(beFalse())
                }
                
                it("cancel button clicked") {
                    viewController.searchBarCancelButtonClicked(searchBar)
                    expect(searchBar.isFirstResponder).to(beFalse())
                }
            }
        }
    }
}


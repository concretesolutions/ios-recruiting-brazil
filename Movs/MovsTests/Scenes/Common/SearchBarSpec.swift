//
//  SearchBarSpec.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class SearchBarSpec: QuickSpec {
    override func spec() {
        describe("SearchBar Spec") {
            
            context("init with coder") {
                it("should raise exception") {
                    let archiver = NSKeyedArchiver(requiringSecureCoding: false)
                    expect(SearchBar(coder: archiver)).to(raiseException())
                }
            }
            
            context("delegate") {
                
                var searchBar: SearchBar!
                
                beforeEach {
                    searchBar = SearchBar(frame: .zero)
                }
                
                it("did begin editing") {
                    searchBar.delegate?.searchBarTextDidBeginEditing!(searchBar)
                    expect(searchBar.showsCancelButton).to(beTrue())
                }
                
                it("did end editing") {
                    searchBar.delegate?.searchBarTextDidEndEditing!(searchBar)
                    expect(searchBar.showsCancelButton).to(beFalse())
                }
                
                it("search button clicked") {
                    searchBar.delegate?.searchBarSearchButtonClicked!(searchBar)
                    expect(searchBar.isFirstResponder).to(beFalse())
                }
                
                it("cancel button clicked") {
                    searchBar.delegate?.searchBarCancelButtonClicked!(searchBar)
                    expect(searchBar.isFirstResponder).to(beFalse())
                }
                
            }
        }
    }
}


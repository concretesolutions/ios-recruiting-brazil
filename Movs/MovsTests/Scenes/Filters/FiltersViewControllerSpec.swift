//
//  FiltersViewControllerSpec.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class FiltersViewControllerSpec: QuickSpec {
    override func spec() {
        describe("FiltersViewController Spec") {
            
            context("init with decoder") {
                
                it("should raise exception") {
                    let archiver = NSKeyedArchiver(requiringSecureCoding: false)
                    expect(FiltersViewController(coder: archiver)).to(raiseException())
                }
            }
            
            context("init") {
                
                var viewController: FiltersViewController!
                
                beforeEach {
                    viewController = FiltersViewController()
                }
                
                it("should not be nil") {
                    expect(viewController).toNot(beNil())
                }
                
                it("should have no filters") {
                    viewController.viewWillAppear(false)
                    expect(viewController.dateFilter).to(beNil())
                    expect(viewController.genreFilter).to(beNil())
                }
            }
        }
    }
}


//
//  FiltersOptionViewControllerSpec.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class FiltersOptionViewControllerSpec: QuickSpec {
    override func spec() {
        describe("FiltersOptionViewController Spec") {
            
            var viewController: FiltersOptionViewController!
            
            context("init with coder") {
                
                it("should raise exception") {
                    let archiver = NSKeyedArchiver(requiringSecureCoding: false)
                    expect(FiltersOptionViewController(coder: archiver)).to(raiseException())
                }
                
            }
            
            context("init with filter type date") {
                
                beforeEach {
                    viewController = FiltersOptionViewController(filter: .date)
                }
                
                it("should not be nil") {
                    expect(viewController).toNot(beNil())
                }
                
                it("should apply filter") {
                    viewController.viewWillAppear(false)
                    expect(viewController.filters.count).toNot(beLessThan(0))
                }
                
                it("should select first cell") {
                    expect(viewController.selectIndex).to(beNil())
                    viewController.didSelectCell(at: 0)
                    expect(viewController.selectIndex).toNot(beNil())
                    expect(viewController.selectIndex).to(equal(0))
                }
                
                it("should select new cell") {
                    viewController.selectIndex = 0
                    viewController.didSelectCell(at: 1)
                    expect(viewController.selectIndex).toNot(beNil())
                    expect(viewController.selectIndex).to(equal(1))
                }
            }
            
            context("init with filter type genre") {
                
                beforeEach {
                    viewController = FiltersOptionViewController(filter: .genre)
                }
                
                it("should not be nil with genre type") {
                    expect(viewController).toNot(beNil())
                }
                
                it("should apply filter with genre type") {
                    viewController.viewWillAppear(false)
                    expect(viewController.filters.count).toNot(beLessThan(0))
                }
                
            }
        }
    }
}


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
            
            context("init with coder") {
                
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
                
                it("should have date filter") {
                    let selected = Filters.Option.Selected(type: .date,
                                                           filterPredicate: "",
                                                           filterName: "")
                    viewController.filter(selected: selected)
                    expect(viewController.dateFilter).toNot(beNil())
                }
                
                it("should have genre filter") {
                    let selected = Filters.Option.Selected(type: .genre,
                                                           filterPredicate: "",
                                                           filterName: "")
                    viewController.filter(selected: selected)
                    expect(viewController.genreFilter).toNot(beNil())
                }
                
                it("should receive filters applied") {
                    let viewModel = Filters.ViewModel(movies: [])
                    viewController.applyFilter(viewModel: viewModel)
                    expect(viewController.filterApply).to(beNil())
                    expect(viewController.activeFilters).to(beNil())
                }
                
                it("should apply no filters") {
                    let sender = UIButton()
                    viewController.pressedApply(sender: sender)
                    expect(viewController.dateFilter).to(beNil())
                    expect(viewController.genreFilter).to(beNil())
                }
                
                it("should apply filters") {
                    let sender = UIButton()
                    let dateFilter = Filters.Option.Selected(type: .date,
                                                             filterPredicate: "",
                                                             filterName: "")
                    let genreFilter = Filters.Option.Selected(type: .genre,
                                                             filterPredicate: "",
                                                             filterName: "")
                    viewController.dateFilter = dateFilter
                    viewController.genreFilter = genreFilter
                    viewController.pressedApply(sender: sender)
                    expect(viewController.dateFilter).toNot(beNil())
                    expect(viewController.genreFilter).toNot(beNil())
                }
                
                it("should apply date filter") {
                    let sender = UIButton()
                    let dateFilter = Filters.Option.Selected(type: .date,
                                                             filterPredicate: "",
                                                             filterName: "")
                    viewController.dateFilter = dateFilter
                    viewController.pressedApply(sender: sender)
                    expect(viewController.dateFilter).toNot(beNil())
                    expect(viewController.genreFilter).to(beNil())
                }
                
                it("should apply genre filters") {
                    let sender = UIButton()
                    let genreFilter = Filters.Option.Selected(type: .genre,
                                                              filterPredicate: "1",
                                                              filterName: "")
                    viewController.genreFilter = genreFilter
                    viewController.pressedApply(sender: sender)
                    expect(viewController.dateFilter).to(beNil())
                    expect(viewController.genreFilter).toNot(beNil())
                }
            }
        }
    }
}


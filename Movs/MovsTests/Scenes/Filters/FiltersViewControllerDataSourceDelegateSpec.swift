//
//  FiltersViewControllerDataSourceDelegateSpec.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class FiltersViewControllerDataSourceDelegateSpec: QuickSpec {
    override func spec() {
        describe("FiltersViewControllerDataSourceDelegate Spec") {
            
            var viewController: FiltersViewController!
            var tableView: FiltersTableView!
            
            context("data source") {
                
                beforeEach {
                    viewController = FiltersViewController()
                    tableView = viewController.tableView
                }
                
                it("should return date cell") {
                    let cell = viewController.tableView(tableView,
                                                        cellForRowAt: IndexPath(item: 0,
                                                                                section: 0))
                    expect(tableView.date).to(equal(cell))
                }
                
                it("should return genre cell") {
                    let cell = viewController.tableView(tableView,
                                                        cellForRowAt: IndexPath(item: 1,
                                                                                section: 0))
                    expect(tableView.genre).to(equal(cell))
                }
                
                it("should return empty cell") {
                    let cell = viewController.tableView(tableView,
                                                        cellForRowAt: IndexPath(item: 3,
                                                                                section: 0))
                    expect(tableView.date).toNot(equal(cell))
                    expect(tableView.genre).toNot(equal(cell))
                }

            }
        }
    }
}


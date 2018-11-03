//
//  FiltersViewControllerSnapshots.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Movs

class FiltersViewControllerSnapshots: QuickSpec {
    override func spec() {
        describe("FiltersViewController Snapshots") {
            context("empty view controller") {
                it("should have table view and apply button") {
                    let viewController = FiltersViewController()
                    expect(viewController.view) == snapshot("FiltersViewController")
                }
            }
        }
    }
}


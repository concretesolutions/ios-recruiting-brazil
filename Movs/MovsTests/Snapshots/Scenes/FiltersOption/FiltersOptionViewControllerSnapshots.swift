//
//  FiltersOptionViewControllerSnapshots.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Movs

class FiltersOptionViewControllerSnapshots: QuickSpec {
    override func spec() {
        describe("FiltersOptionViewController Snapshots") {
            context("empty view controller") {
                it("should have empty table view") {
                    let viewController = FiltersOptionViewController(filter: .date)
                    expect(viewController.view) == snapshot("FiltersOptionViewControllerDate")
                }
                
                it("should have empty table view") {
                    let viewController = FiltersOptionViewController(filter: .genre)
                    expect(viewController.view) == snapshot("FiltersOptionViewControllerGenre")
                }
            }
        }
    }
}


//
//  FavoritesViewControllerSnapshots.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Movs

class FavoritesViewControllerSnapshots: QuickSpec {
    override func spec() {
        describe("FavoritesViewController Snapshots") {
            context("empty view controller") {
                it("should have search bar and empty table view") {
                    let viewController = FavoritesViewController(nibName: nil, bundle: nil)
                    expect(viewController.view) == snapshot("FavoritesViewController")
                }
            }
        }
    }
}


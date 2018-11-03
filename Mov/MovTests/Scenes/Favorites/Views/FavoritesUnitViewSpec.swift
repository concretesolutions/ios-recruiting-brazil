//
//  FavoritesUnitViewSpec.swift
//  MovTests
//
//  Created by Miguel Nery on 03/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Quick
import Nimble

@testable import Mov

class FavoritesUnitViewSpec: QuickSpec {
    override func spec() {
        var view: FavoritesUnitView!
        describe("FavoritesUnitView") {
            context("when initialized") {
                beforeEach {
                    view = FavoritesUnitView(frame: .zero)
                }
                
                it("add own subviews") {
                    expect(view.subviews).to(contain([view.poster, view.overviewStack]))
                }
            }
        }
    }
}


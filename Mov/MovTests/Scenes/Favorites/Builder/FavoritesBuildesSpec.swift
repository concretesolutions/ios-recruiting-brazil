//
//  FavoritesBuildesSpec.swift
//  MovTests
//
//  Created by Miguel Nery on 03/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Quick
import Nimble

@testable import Mov

class FavoritesBuilderSpec: QuickSpec {
    override func spec() {
        describe("Favorites builder") {
            context("when building") {
                var vc: FavoritesViewController?
                
                beforeEach {
                    vc = FavoritesBuilder.build()
                }
                
                it("should build non nil view controller") {
                    expect(vc).notTo(beNil())
                }
                
                it("should have view controller assigned a interactor") {
                    expect(vc?.interactor).notTo(beNil())
                }
            }
        }
    }
}

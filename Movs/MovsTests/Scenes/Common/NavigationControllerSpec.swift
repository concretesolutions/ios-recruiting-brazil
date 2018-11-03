//
//  NavigationControllerSpec.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class NavigationControllerSpec: QuickSpec {
    override func spec() {
        describe("NavigationController Spec") {
            context("init with coder") {
                it("should raise exception") {
                    let archiver = NSKeyedArchiver(requiringSecureCoding: false)
                    expect(NavigationController(coder: archiver)).to(raiseException())
                }
            }
        }
    }
}


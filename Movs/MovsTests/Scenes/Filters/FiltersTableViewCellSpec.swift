//
//  FiltersTableViewCellSpec.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class FiltersTableViewCellSpec: QuickSpec {
    override func spec() {
        describe("FiltersTableViewCell Spec") {
            context("init with coder") {
                
                it("should raise exception") {
                    let archiver = NSKeyedArchiver(requiringSecureCoding: false)
                    expect(FiltersTableViewCell(coder: archiver)).to(raiseException())
                }
            }
        }
    }
}


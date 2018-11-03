//
//  FavoritesTableViewCellSpec.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class FavoritesTableViewCellSpec: QuickSpec {
    override func spec() {
        describe("FavoritesTableViewCell Spec") {
            
            context("init with decoder") {
                
                it("should raise exception") {
                    let archiver = NSKeyedArchiver(requiringSecureCoding: false)
                    expect(FavoritesTableViewCell(coder: archiver)).to(raiseException())
                }
                
            }
            
            context("init with style") {
                
                var cell: FavoritesTableViewCell!
                
                beforeEach {
                    cell = FavoritesTableViewCell(style: .default, reuseIdentifier: "")
                }
                
                it("should not be nil") {
                    expect(cell).toNot(beNil())
                }
                
            }
        }
    }
}


//
//  MovieDetailButtonCellSpec.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class MovieDetailButtonCellSpec: QuickSpec {
    override func spec() {
        describe("MovieDetailButtonCell Spec") {
            
            var cell: MovieDetailButtonCell!
            
            context("init with coder") {
                
                it("should raise a exception") {
                    let archiver = NSKeyedArchiver(requiringSecureCoding: false)
                    expect(MovieDetailButtonCell(coder: archiver)).to(raiseException())
                }
            }
            
            context("init with style") {
                
                beforeEach {
                    cell = MovieDetailButtonCell(style: .default, reuseIdentifier: "")
                }
                
                it("should not be nil") {
                    expect(cell).toNot(beNil())
                }
                
            }
        }
    }
}


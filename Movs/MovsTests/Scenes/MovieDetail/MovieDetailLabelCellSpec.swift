//
//  MovieDetailLabelCellSpec.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class MovieDetailLabelCellSpec: QuickSpec {
    override func spec() {
        describe("MovieDetailLabelCell Spec") {
            
            context("init with decoder") {
                
                it("should raise a exception") {
                    let archiver = NSKeyedArchiver(requiringSecureCoding: false)
                    expect(MovieDetailLabelCell(coder: archiver)).to(raiseException())
                }
            }
            
            context("init with style") {
                
                var cell: MovieDetailLabelCell!
                
                beforeEach {
                    cell = MovieDetailLabelCell(style: .default, reuseIdentifier: "")
                }
                
                it("should not be nil") {
                    expect(cell).toNot(beNil())
                }
                
            }
        }
    }
}


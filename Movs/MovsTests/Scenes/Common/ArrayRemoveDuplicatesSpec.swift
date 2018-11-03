//
//  ArrayRemoveDuplicatesSpec.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class ArrayRemoveDuplicatesSpec: QuickSpec {
    override func spec() {
        describe("Remove array duplicates Spec") {
            
            var array = [1, 1]
            
            context("remove duplicates") {
                
                it("should have only one member") {
                    array.removeDuplicates()
                    expect(array.count).to(equal(1))
                }
            }
        }
    }
}


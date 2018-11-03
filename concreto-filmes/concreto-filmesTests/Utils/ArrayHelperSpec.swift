//
//  ArrayHelperSpec.swift
//  concreto-filmesTests
//
//  Created by Leonel Menezes on 02/11/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import Quick
import Nimble
@testable import concreto_filmes

class ArrayHelperSpec: QuickSpec {
    override func spec() {
        describe("Array Helper") {
            
            var array: [Int] = []
            
            beforeEach {
                array = [1, 4, 6, 6, 9, 6]
            }
            
            it("should return unique array", closure: {
                expect(array.unique.sorted() == [1, 4, 6, 9]).to(beTruthy())
            })
            
        }
    }
}

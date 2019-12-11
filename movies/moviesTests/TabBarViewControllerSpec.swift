//
//  TabBarViewControllerSpec.swift
//  moviesTests
//
//  Created by Jacqueline Alves on 01/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class TabBarViewControllerSpec: QuickSpec {
    override func spec() {
        var sut: TabBarViewController!
        
        describe("the 'Tab bar' ") {
            beforeEach {
                sut = TabBarViewController()
                _ = sut.view
            }
            
            context("when initialized ") {
                it("is not nil.") {
                    expect(sut).toNot(beNil())
                }
                
                it("should have two tab items.") {
                    expect(sut.viewControllers?.count).to(be(2))
                }
            }
        }
    }
}

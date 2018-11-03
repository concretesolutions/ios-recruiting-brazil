//
//  TabControllerSpec.swift
//  concreto-filmesTests
//
//  Created by Leonel Menezes on 02/11/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import concreto_filmes

class TabControllerSpec: QuickSpec {
    override func spec() {
        
        describe("Tab bar") {
            var tabController: TabController!
            
            beforeEach {
                tabController = TabController()
            }
            
            it("Should have two view controllers", closure: {
                expect(tabController.viewControllers?.count == 2).to(beTruthy())
            })
        }
    }
}

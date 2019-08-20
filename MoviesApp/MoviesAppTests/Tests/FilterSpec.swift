//
//  FilterSpec.swift
//  MoviesAppTests
//
//  Created by Eric Winston on 8/20/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import MoviesApp

class FilterSpec: QuickSpec{
    
    override func spec() {
        
        let controller = FilterController()
        
        describe("Check if the view is loading") {
            it("view has to be equal to the FilterView"){
                controller.viewDidLoad()
                expect(controller.view) == controller.screen
            }
        }
    }
}

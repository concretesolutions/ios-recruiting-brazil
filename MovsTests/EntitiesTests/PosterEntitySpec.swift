//
//  PosterEntitySpec.swift
//  MovsTests
//
//  Created by Bruno Chagas on 02/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import Quick
import Nimble
import UIKit

@testable import Movs

class PosterEntitySpec: QuickSpec {
    override func spec() {
        
        var sut: PosterEntity?
        
        beforeEach {
            sut = PosterEntity(poster: UIImage())
        }
        describe("A poster") {
            it("Has to not have empty properties", closure: {
                //expect(sut?.movieId).toNot(beNil())
                expect(sut?.poster).toNot(beNil())
            })
        }
        
    }
}

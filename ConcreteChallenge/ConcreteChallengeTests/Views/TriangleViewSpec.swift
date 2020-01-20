//
//  TriangleViewSpec.swift
//  ConcreteChallengeTests
//
//  Created by Kaique Damato on 19/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import ConcreteChallenge

class TriangleViewSpec: QuickSpec {
    override func spec() {
        
        let triangleView = TriangleView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        describe("set up view") {
            it("with basic layout") {
                expect(triangleView).to( haveValidSnapshot() )
            }
        }
    }
}

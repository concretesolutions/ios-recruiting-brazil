//
//  TitleViewSpec.swift
//  ConcreteChallengeTests
//
//  Created by Kaique Damato on 19/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import ConcreteChallenge

class TitleViewSpec: QuickSpec {
    override func spec() {
        
        let titleView = TitleView(title: "Suicide Squad")
        
        describe("set up view") {
            
            beforeSuite {
                titleView.frame = CGRect(x: 0, y: 0, width: 400, height: 100)
            }
            
            it("with basic layout") {
                expect(titleView).to( haveValidSnapshot() )
            }
        }
    }
}

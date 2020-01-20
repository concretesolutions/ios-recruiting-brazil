//
//  BodyViewSpec.swift
//  ConcreteChallengeTests
//
//  Created by Kaique Damato on 19/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import ConcreteChallenge

class BodyViewSpec: QuickSpec {
    
    override func spec() {
        
        let bodyView = BodyView(text: "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.")
        
        describe("set up view") {
            beforeSuite {
                bodyView.frame = UIScreen.main.bounds
            }
            
            it("with basic layout") {
                expect(bodyView).to( haveValidSnapshot() )
            }
        }
    }
}

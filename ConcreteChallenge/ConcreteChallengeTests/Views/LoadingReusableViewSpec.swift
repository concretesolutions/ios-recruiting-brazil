//
//  LoadingReusableViewSpec.swift
//  ConcreteChallengeTests
//
//  Created by Kaique Damato on 19/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import ConcreteChallenge

class LoadingReusableViewSpec: QuickSpec {
    override func spec() {
        
        let loadingReusableView = LoadingReusableView()
        
        describe("set up view") {
            
            beforeSuite {
                loadingReusableView.frame = UIScreen.main.bounds
                loadingReusableView.setup()
                loadingReusableView.backgroundColor = .white
            }
            
            it("with basic layout") {
                expect(loadingReusableView).to( haveValidSnapshot() )
            }
        }
    }
}

//
//  StateMachineSpec.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 02/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class StateMachineSpec: QuickSpec {
    override func spec() {
        describe("State Machine Spec") {
            context("States") {
                var stateMachine: StateMachine!
                
                beforeEach {
                    let state = State()
                    stateMachine = StateMachine(states: [state])
                    _ = stateMachine.enter(State.self)
                }
                
                it("should be able to enter state") {
                    expect(stateMachine.canEnterState(State.self)).to(beTrue())
                }
            }
        }
    }
}



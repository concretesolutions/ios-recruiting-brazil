//
//  StateMachine.swift
//  Movs
//
//  Created by Ricardo Rachaus on 30/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

class StateMachine: NSObject {
    private(set) var currentState: State?
    private var states: Set<State>
    
    init(states: [State]) {
        self.states = Set<State>(states)
    }
    
    func canEnterState(_ stateClass: AnyClass) -> Bool {
        if let currentState = currentState {
            return currentState.isValidNextState(stateClass)
        }
        return true
    }
    
    func enter(_ stateClass: AnyClass) -> Bool {
        if canEnterState(stateClass) {
            let previousState = currentState
            states.forEach { (state) in
                if state.isKind(of: stateClass) {
                    currentState = state
                    currentState?.didEnter(from: previousState)
                }
            }
            return true
        }
        return false
    }
}

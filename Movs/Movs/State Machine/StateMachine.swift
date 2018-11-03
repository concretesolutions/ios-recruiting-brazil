//
//  StateMachine.swift
//  Movs
//
//  Created by Ricardo Rachaus on 30/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation
import GameplayKit

/**
 Base state machine class to manage states.
 */
class StateMachine: NSObject {
    
    /**
     Current state that the machine is. First state is nil.
     */
    private(set) var currentState: State?
    private var states: Set<State>
    
    /**
     Initialize state machine.
     
     - parameters:
         - states: All states of the state machine.
     
     - Returns: self : StateMachine
     */
    init(states: [State]) {
        self.states = Set<State>(states)
    }
    
    /**
     Check if is possible to enter a state.
     
     - parameters:
         - stateClass: Class of the state to enter.
     
     - Returns: canEnterState : Bool
     */
    func canEnterState(_ stateClass: AnyClass) -> Bool {
        if let currentState = currentState {
            return currentState.isValidNextState(stateClass)
        }
        return true
    }
    
    /**
     Enter the state if it can.
     
     - parameters:
         - stateClass: Class of the state to enter.
     
     - Returns: didEnter : Bool
     */
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

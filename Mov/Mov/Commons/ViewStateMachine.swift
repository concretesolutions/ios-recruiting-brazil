//
//  MovieGridStateMachine.swift
//  Mov
//
//  Created by Miguel Nery on 28/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

class ViewStateMachine {
    private(set) var currentState: ViewState?
    
    func enter(state: ViewState) {
        if let currentState = self.currentState {
            currentState.onExit()
        } else {/*do nothing*/}
        
        state.enter()
        self.currentState = state
    }
}

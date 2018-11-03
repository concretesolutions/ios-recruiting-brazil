//
//  State.swift
//  Movs
//
//  Created by Ricardo Rachaus on 01/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

class State: NSObject {
    func didEnter(from previousState: State?) {}
    func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return true
    }
    func willExit(to nextState: State) {}
}

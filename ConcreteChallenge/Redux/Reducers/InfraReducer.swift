//
//  InfraReducer.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 24/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import ReSwift
import ReSwiftThunk
import Reachability

struct InfraState: StateType, Equatable {
    var isConnected: Bool = false
    var reachabilityStarted: Bool = false
    var reachabilityConnection: Reachability.Connection = .unavailable
}

func infraReducer(action: InfraActions, state: InfraState?, rootState: RootState?) -> InfraState {
    var state = state ?? InfraState()

    switch action {
    case .reachabilityChange(let reachability):
        state.reachabilityConnection = reachability.connection
        state.reachabilityStarted = true
        state.isConnected = true
    case .reachabilityUnreachable:
        state.reachabilityConnection = .unavailable
        state.isConnected = false
    case .unableToStartReachability:
        state.reachabilityConnection = .unavailable
        state.reachabilityStarted = false
        state.isConnected = false
    case .reachabilityStarted:
        state.reachabilityStarted = true
        state.isConnected = false
    }
    return state
}

//
//  InfraThunk.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 24/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import RxSwift
import ReSwift
import ReSwiftThunk
import Reachability

class InfraThunk {
    static let reachability = try! Reachability()
    
    static func startReachability(then nextActions: [Action]) -> Thunk<RootState> {
        
        return Thunk<RootState> { dispatch, getState in
            guard let state = getState() else { return }
            
            var nextActions = nextActions
            
            reachability.whenReachable = { reachability in
                dispatch(InfraActions.reachabilityChange(reachability))
                nextActions.forEach(dispatch)
                nextActions = []
            }
            reachability.whenUnreachable = { _ in
                dispatch(InfraActions.reachabilityUnreachable)
            }

            do {
                try reachability.startNotifier()
                dispatch(InfraActions.reachabilityStarted)
            } catch {
                dispatch(InfraActions.unableToStartReachability)
            }
            
        }
    }
}

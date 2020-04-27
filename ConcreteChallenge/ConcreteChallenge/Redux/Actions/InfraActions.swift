//
//  InfraActions.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 24/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import ReSwift
import Reachability

enum InfraActions: Action {
    case reachabilityChange(_ reachability: Reachability)
    case reachabilityUnreachable
    case unableToStartReachability
    case reachabilityStarted
}

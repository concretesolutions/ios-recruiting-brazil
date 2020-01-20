//
//  Network.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 20/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation
import Network

enum NetworkStatus {
    case connected
    case desconected
}

class Network {
    private let monitor = NWPathMonitor()
    
    public static let shared = Network.init()
    public var status: NetworkStatus {
        get {
            if monitor.currentPath.status == .unsatisfied || monitor.currentPath.status == .requiresConnection {
                return .desconected
            } else {
                return .connected
            }
        }
    }
    private init() {
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
    }
    
    func observerNetwork(handle: @escaping (_ status: NetworkStatus ) -> Void) {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                handle(.connected)
            } else {
                handle(.desconected)
            }
        }
    }
}

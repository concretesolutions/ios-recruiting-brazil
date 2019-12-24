//
//  NetworkService.swift
//  Movs
//
//  Created by Lucca França Gomes Ferreira on 20/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Foundation
import UIKit
import Network

final class NetworkService {
    
    static let shared = NetworkService()
    
    private let monitor = NWPathMonitor()
    private let monitorQueue = DispatchQueue(label: "Monitor")
    
    @Published var status: NWPath.Status = .satisfied
    
    private init() {
        self.monitor.pathUpdateHandler = { path in
            self.status = path.status
        }
        
        self.monitor.start(queue: monitorQueue)
    }
    
}
